import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roombud/services/auth.dart';
import 'package:roombud/services/database.dart';
import 'package:roombud/utils/shared_data.dart';

class RoomieProfile extends StatefulWidget {
  @override
  _RoomieProfileState createState() => _RoomieProfileState();
}

class _RoomieProfileState extends State<RoomieProfile> {
  DatabaseService _db;
  final AuthService _auth = AuthService();
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedData().getDataFromSharedData('uid').then((data) {
      _db = DatabaseService(uid: data);
      setState(() async {
        DocumentSnapshot userSnapshot = await _db.getUser();
        user = userSnapshot.data;
        print(user);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(user['profile']),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.person),
              SizedBox(
                width: 10.0,
              ),
              Text(user['name'], style: TextStyle(color: Colors.black,fontSize:18.0, fontWeight: FontWeight.bold))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Icon(Icons.email),
              SizedBox(
                width: 10.0,
              ),
              Text(user['email'], style: TextStyle(color: Colors.black,fontSize:18.0, fontWeight: FontWeight.bold))
            ]),
             SizedBox(height: 30.0),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      "Get Profile Details",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.settings),
                    Text(
                      "Preferences",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/update-profile');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.help),
                    Text(
                      "Update Profile",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await _auth.signOut();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
