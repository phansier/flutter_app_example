import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  String _userEmail;
  String _userPassword;

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get userPassword => _userPassword;

  set userPassword(String value) {
    _userPassword = value;
  }

  FirebaseUser _firebaseUser;

  FirebaseUser get firebaseUser => _firebaseUser;

  set firebaseUser(FirebaseUser value) {
    _firebaseUser = value;
  }

  bool _newUser;

  bool get newUser => _newUser!= null && _newUser;

  set newUser(bool value) {
    _newUser = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'UserModel{_userEmail: $_userEmail, _userPassword: $_userPassword, _firebaseUser: $_firebaseUser, _newUser: $_newUser}';
  }
}
