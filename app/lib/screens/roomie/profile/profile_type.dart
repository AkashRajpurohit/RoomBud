import 'package:flutter/material.dart';
import 'package:roombud/services/database.dart';
import 'package:roombud/utils/constants.dart';
import 'package:roombud/utils/shared_data.dart';

class ProfileType extends StatefulWidget {

  @override
  _ProfileTypeState createState() => _ProfileTypeState();
}

class _ProfileTypeState extends State<ProfileType> {
  final SharedData _data = SharedData();

  DatabaseService _db;

  Future getDB() async {
    var data = await _data.getDataFromSharedData("uid");
    _db = DatabaseService(uid: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Become a",
              style: TextStyle(fontSize: 26.0),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    await _data.addDataToSharedData("usertype", "tenant");
                    Navigator.pushNamed(context, '/tenant');
                    await getDB();
                    await _db.addUserData({ 'usertype': 'tenant' });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 60.0, horizontal: 35.0),
                    decoration: profileTypeDecoration,
                    child: Text("TENANT"),
                  ),
                ),
                Text("OR"),
                InkWell(
                  onTap: () async {
                    await _data.addDataToSharedData("usertype", "roomie");
                    Navigator.pushNamed(context, '/roomie');
                    await getDB();
                    await _db.addUserData({ 'usertype': 'roomie' });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 60.0, horizontal: 35.0),
                    decoration: profileTypeDecoration,
                    child: Text("ROOMIE"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
