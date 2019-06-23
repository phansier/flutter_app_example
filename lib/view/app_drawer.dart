import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/presenter/navigation.dart';
import 'package:scoped_model/scoped_model.dart';

class AppDrawer {
  static Widget buildDrawer(BuildContext context, String selectedItem) {
    void _flowersScreen() {
      Navigation.goToFlowersScreen(context);
    }

    void _sellersMode() {
      Navigation.goToSellersMode(context);
    }

    void _chatMode() {
      Navigation.goToChatMode(context);
    }

    String photoUrl = ScopedModel.of<UserModel>(context).firebaseUser.photoUrl;
    String email = ScopedModel.of<UserModel>(context).firebaseUser.email;

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: photoUrl == null ? Text(email.substring(0, 2)) : null,
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            ),
            accountEmail: Text(email),
            accountName: Text(""),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Main screen"),
            selected: selectedItem == "home",
            onTap: _flowersScreen,
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Go to Seller's mode"),
            selected: selectedItem == "add_shopping_cart",
            onTap: _sellersMode,
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text("Chat"),
            selected: selectedItem == "chat",
            onTap: _chatMode,
          ),
          AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: "Fluber",
              applicationVersion: "1.0 dev",
              applicationIcon: Image(
                image: AssetImage("images/girl.png"),
                width: 80.0,
                height: 80.0,
              ),
              applicationLegalese: "Made by: Andrey Beryukhov")
        ],
      ),
    );
  }
}
