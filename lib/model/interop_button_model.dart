import 'package:scoped_model/scoped_model.dart';

class InteropButtonModel extends Model {
  String _text = "Order";

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }
}
