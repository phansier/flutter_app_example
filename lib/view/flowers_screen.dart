import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/bouquet.dart';
import 'package:flutter_app/model/bouquets_list.dart';
import 'package:flutter_app/model/florist.dart';
import 'package:flutter_app/model/interop_button_model.dart';
import 'package:flutter_app/view/app_drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';

class FlowersScreen extends StatelessWidget {
  static MapController _mapController = new MapController();
  static List _markers = List<Marker>();
  static FlutterMap _map = FlutterMap(
    mapController: _mapController,
    options: new MapOptions(
      center: new LatLng(0, 0),
      zoom: 16.0,
    ),
    layers: [
      new TileLayerOptions(
        urlTemplate: "https://api.tiles.mapbox.com/v4/"
            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoicGhhbnNpZXIiLCJhIjoiY2puaHQ2cXJ6MGRkejNrdGE4dmc3MHJubyJ9.9DgkDtP5PL3iMMEZCgkvlQ',
          'id': 'mapbox.streets',
        },
      ),
      new MarkerLayerOptions(
        markers: _markers,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    //_initMap();
    return Scaffold(
      appBar: AppBar(title: Text("Main screen")),
      drawer: AppDrawer.buildDrawer(context, "home"),
      body: _columnFromBouquets(context),
    );
  }

  Widget _columnFromBouquets(BuildContext context) {
    return ScopedModelDescendant<BouquetsListModel>(
        builder: (context, child, bouquets) {
      if (bouquets.list == null) {
        print("start loading");
        _loadList().then((QuerySnapshot qs) {
          List<Bouquet> list =
              qs.documents.map((d) => Bouquet.fromSnapshot(d)).toList();
          print("loaded list" + list.toString());
          bouquets.list = list;
        }) /*.catchError((e) => print(e.toString() + e.runtimeType.toString()))*/;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _bouquetsRow(context, bouquets.hasLeft(), bouquets.hasRight(),
              bouquets.currentBouquet),
          _bouquetStack(context)
        ],
      );
    });
  }

  Future<QuerySnapshot> _loadList() async {
    final Firestore _firestore = Firestore.instance;
    final QuerySnapshot list =
        await _firestore.collection('bouquet').getDocuments();
    return list;
  }

  Widget _bouquetsRow(
      BuildContext context, bool hasLeft, bool hasRight, Bouquet bouquet) {
    return Flexible(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_left,
            ),
            onPressed: hasLeft
                ? () {
                    ScopedModel.of<BouquetsListModel>(context).currentIndex -=
                        1;
                  }
                : null,
            iconSize: 40.0,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: _buildCard(context, bouquet),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_right,
            ),
            onPressed: hasRight
                ? () {
                    ScopedModel.of<BouquetsListModel>(context).currentIndex +=
                        1;
                  }
                : null,
            iconSize: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _bouquetStack(BuildContext context) {
    return Flexible(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          _buildMap(context),
          Positioned(
            bottom: 8.0,
            child: _createButton(context),
          )
        ],
      ),
    );
  }

  static const _platform = MethodChannel('interop_example');
  static final _interopButton = InteropButtonModel();

  Widget _createButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
        child: ScopedModel<InteropButtonModel>(
          model: _interopButton,
          child: ScopedModelDescendant<InteropButtonModel>(
              builder: (context, child, buttonModel) => RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Future<void> _tryInterop() async {
                        try {
                          String result = await _platform
                              .invokeMethod('tryInterop', ['4', '2']);
                          buttonModel.text = result;
                        } on PlatformException catch (e) {
                          print("_tryInterop exception " + e.toString());
                        }
                      }

                      _tryInterop();
                    },
                    child: Text(buttonModel.text),
                  )),
        ));
  }

  Widget _buildCard(BuildContext context, Bouquet bouquet) {
    if (bouquet == null) {
      return Card(color: Colors.red);
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: ScopedModel<Florist>(
                model: bouquet.florist,
                child: ScopedModelDescendant<Florist>(
                    builder: (context, child, florist) => Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 8.0, 8.0, 0.0),
                          child: InputChip(
                            avatar: florist.imagePath == null ||
                                    florist.imagePath == ""
                                ? Card(color: Colors.orange)
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(florist.imagePath),
                                  ),
                            label:
                                Text(florist.name != null ? florist.name : ""),
                            isEnabled: true,
                            onPressed: () {},
                          ),
                        ))),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: NetworkImage(bouquet.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
            child: Text(
              bouquet.description,
              style: subheadTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
            child: Text(
              bouquet.price,
              style: titleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    Bouquet bouquet = ScopedModel.of<BouquetsListModel>(context).currentBouquet;
    if (bouquet == null) {
      return Card();
    }
    _markers.clear();
    _markers.add(new Marker(
      width: 80.0,
      height: 80.0,
      point: _getLatLng(bouquet.geopoint),
      builder: (ctx) => new Container(
        child: new Icon(
          Icons.local_florist,
          size: 80.0,
          color: Color(0xffBB6BD9),
        ),
      ),
    ));

    if (_mapController.ready) {
      _mapController.move(_getLatLng(bouquet.geopoint), 16.0);
    } else {
      _mapController.onReady
          .then((_) => _mapController.move(_getLatLng(bouquet.geopoint), 16.0));
    }
    return _map;
  }
}

LatLng _getLatLng(GeoPoint geopoint) =>
    LatLng(geopoint.latitude, geopoint.longitude);

TextStyle titleTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, letterSpacing: 0.15);
TextStyle subheadTextStyle = TextStyle(fontSize: 16.0, letterSpacing: 0.15);
