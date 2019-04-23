import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/florist.dart';

class Bouquet {
  Florist florist;
  String imagePath;
  String description;
  String price;
  GeoPoint geopoint;
  DocumentReference reference;

  Bouquet(
      this.florist, this.imagePath, this.description, this.price, this.geopoint,
      {this.reference});

  Bouquet.fromMap(Map<Object, dynamic> map, {this.reference}) {
    assert(map['florist'] != null);
    assert(map['description'] != null);
    assert(map['price'] != null);
    assert(map['geopoint'] != null);

    this.florist = Florist(map['florist']);
    this.imagePath = map['imagePath'];
    this.description = map['description'];
    this.price = map['price'];
    this.geopoint = map['geopoint'];
  }

  @override
  String toString() {
    return 'Bouquet{florist: $florist, imagePath: $imagePath, description: $description, price: $price, geopoint: $geopoint, reference: $reference}';
  }

  Bouquet.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
