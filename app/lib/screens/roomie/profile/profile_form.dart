import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roombud/services/database.dart';
import 'package:roombud/utils/get_lat_lng.dart';
import 'package:roombud/utils/shared_data.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _user = {};
  List<String> prefs = [];

  final List<bool> isSelected1 = [false, false];
  final List<String> food = ['Vegetarain', 'Non Vegetarian'];
  String foodPref;

  final List<bool> isSelected2 = [false, false];
  final List<String> isAlcoholic = ['Alcoholic', 'Non Alcoholic'];
  String alcoholPref;

  final List<bool> isSelected3 = [false, false];
  final List<String> isSmoker = ['Smoking', 'Non Smoking'];
  String smokerPref;

  final List<bool> isSelected4 = [false, false];
  final List<String> riser = ['Early Morning', 'Late Night'];
  String riserPref;

  final List<bool> isSelected5 = [false, false];
  final List<String> quality = ['Introvert', 'Extrovert'];
  String qualityPref;

  DatabaseService _db;
  var currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedData().getDataFromSharedData('uid').then((data) {
      _db = DatabaseService(uid: data);
      setState(() async {
        DocumentSnapshot userSnapshot = await _db.getUser();
        currentUser = userSnapshot.data;
        print(currentUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('Update Profile'), backgroundColor: Color(0xff5321ad)),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Gender'),
                          onSaved: (val) => setState(() {
                            _user['gender'] = val;
                          }),
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Phone Number'),
                          onSaved: (val) => setState(() {
                            _user['phone'] = val;
                          }),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Location'),
                          onSaved: (val) => setState(() {
                            // _user['location'] = val;
                            _user['coordinates'] = LatLng().getLatLng();
                          }),
                        ),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Aadhar No'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 12) {
                                return 'Please enter Aadhar Details';
                              }
                              return '';
                            },
                            onSaved: (val) =>
                                setState(() => _user['aadhar'] = val)),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Bio'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter a suitable bio';
                              }
                              return '';
                            },
                            onSaved: (val) =>
                                setState(() => _user['bio'] = val)),
                        SizedBox(height: 20.0),
                        Text(
                          'Food',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Vegetarian")),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Non Vegetarian")),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected1.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected1[buttonIndex] = true;
                                } else {
                                  isSelected1[buttonIndex] = false;
                                }
                              }
                              int ind = isSelected1.indexOf(true);
                              foodPref = food[ind];
                            });
                          },
                          isSelected: isSelected1,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Alcohol',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Alcoholic")),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Non Alcoholic")),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected2.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected2[buttonIndex] = true;
                                } else {
                                  isSelected2[buttonIndex] = false;
                                }
                              }
                              int ind = isSelected2.indexOf(true);
                              alcoholPref = isAlcoholic[ind];
                            });
                          },
                          isSelected: isSelected2,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Smoking',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Smoker")),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Non Smoker")),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected3.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected3[buttonIndex] = true;
                                } else {
                                  isSelected3[buttonIndex] = false;
                                }
                              }
                              int ind = isSelected3.indexOf(true);
                              smokerPref = isSmoker[ind];
                            });
                          },
                          isSelected: isSelected3,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Quality',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Introvert")),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Extrovert")),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected5.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected5[buttonIndex] = true;
                                } else {
                                  isSelected5[buttonIndex] = false;
                                }
                              }
                              int ind = isSelected5.indexOf(true);
                              qualityPref = quality[ind];
                            });
                          },
                          isSelected: isSelected5,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Riser',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Early Morning")),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Late Night")),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected4.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected4[buttonIndex] = true;
                                } else {
                                  isSelected4[buttonIndex] = false;
                                }
                              }
                              int ind = isSelected4.indexOf(true);
                              riserPref = riser[ind];
                            });
                          },
                          isSelected: isSelected4,
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: RaisedButton(
                                color: Color(0xff5321ad),
                                onPressed: () async{
                                  _formKey.currentState.save();
                                  _user['preferences'] = [
                                    foodPref,
                                    alcoholPref,
                                    smokerPref,
                                    qualityPref,
                                    riserPref
                                  ];
                                  // print(_user);
                                  await _db.addUserData(_user);
                                  Navigator.of(context).pop();
                                  // if (form.validate()) {

                                  // _user.save();
                                  // _showDialog(context);
                                  // }
                                },
                                child: Text('Save',style:TextStyle(color: Colors.white)))),
                      ]))),
        ));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
