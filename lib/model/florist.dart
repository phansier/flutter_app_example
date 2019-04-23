import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class Florist extends Model {
  String name;
  String imagePath;

  Florist(String path) {
    _loadFlorist(path).then((DocumentSnapshot ds) {
      name = ds.data['name'];
      imagePath = ds.data['imagePath'];
      notifyListeners();
    }).catchError((e) => print(e.toString() + e.runtimeType.toString()));
  }

  Future<DocumentSnapshot> _loadFlorist(String path) async {
    final Firestore _firestore = Firestore.instance;
    return await _firestore.document(path).get();
  }

  @override
  String toString() {
    return 'Florist{name: $name, imagePath: $imagePath}';
  }
}
