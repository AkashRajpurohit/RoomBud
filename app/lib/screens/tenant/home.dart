import 'package:flutter/material.dart';
import 'package:roombud/services/auth.dart';

class TenantHome extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Tenant"),
          RaisedButton(
            onPressed: () {
              _auth.signOut();
            },
            child: Text('Logout'),
          )
        ],
      )),
    );
  }
}
