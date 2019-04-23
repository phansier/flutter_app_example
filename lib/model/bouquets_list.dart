import 'package:flutter_app/model/bouquet.dart';
import 'package:scoped_model/scoped_model.dart';

class BouquetsListModel extends Model {
  List<Bouquet> _list;

  int _currentIndex = 0;

  List<Bouquet> get list => _list;

  set list(List<Bouquet> value) {
    _list = value;
    notifyListeners();
  }

  Bouquet get currentBouquet => _list != null && _list.length > _currentIndex
      ? _list[_currentIndex]
      : null;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  bool hasLeft() {
    return _currentIndex > 0;
  }

  bool hasRight() {
    return _list != null && _currentIndex < _list.length - 1;
  }
}
