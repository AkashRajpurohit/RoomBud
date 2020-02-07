import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roombud/screens/login.dart';
import 'package:roombud/screens/roomie/home/home.dart';
import 'package:roombud/screens/roomie/profile/profile_type.dart';
import 'package:roombud/screens/tenant/home.dart';
import 'package:roombud/utils/shared_data.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _usertype;

  @override
  void initState() {
    super.initState();

    SharedData().getDataFromSharedData("usertype").then((data) {
      setState(() {
        _usertype = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.hasData) {
          if(_usertype == "roomie") {
            return RoomieHome();
          } else if(_usertype == "tenant") {
            return TenantHome();
          } else {
            return ProfileType();
          }
        } else {
          return LoginScreen();
        }
      },
    );
  }
}