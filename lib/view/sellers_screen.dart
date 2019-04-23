import 'package:flutter/material.dart';
import 'package:flutter_app/view/flowers_screen.dart';
import 'package:flutter_app/model/bouquet.dart';
import 'package:flutter_app/model/bouquets_list.dart';
import 'package:flutter_app/view/app_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class SellersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SellersScreenState();
}

class SellersScreenState extends State<SellersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seller\'s screen')),
      body: _buildBody(context),
      drawer: AppDrawer.buildDrawer(context, "add_shopping_cart"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
        child: Text(
          "2 booking requests",
          style: subheadTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
        child: Text(
          "1 booking has been cancelled",
          style: subheadTextStyle,
        ),
      ),
      Flexible(
        fit: FlexFit.loose,
        child: ScopedModelDescendant<BouquetsListModel>(
          builder: (context, child, bouquets) => GridView.count(
              crossAxisCount: 2,
              children: bouquets.list != null
                  ? bouquets.list
                      .map((b) => _buildBouquetCard(context, b))
                      .toList()
                  : Card()),
        ),
      ),
      _createButton(context),
    ]);
  }

  Widget _createButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () {},
        child: Text('Add new bouquet'),
      ),
    );
  }

  Widget _buildBouquetCard(BuildContext context, Bouquet bouquet) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
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
    ));
  }
}
