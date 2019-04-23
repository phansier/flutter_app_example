import 'package:flutter/material.dart';
import 'package:flutter_app/model/bouquets_list.dart';
import 'package:flutter_app/view/fluber_login_screen.dart';
import 'package:flutter_app/model/user.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final user = UserModel();
  final bouquets = BouquetsListModel();

  runApp(ScopedModel<UserModel>(
      model: user,
      child: ScopedModel<BouquetsListModel>(
          model: bouquets,
          child: MaterialApp(
            title: 'Fluber',
            theme: new ThemeData(
              primaryColor: Color(0xffBB6BD9),
            ),
            home: FluberLoginScreen(),
          ))));
}
