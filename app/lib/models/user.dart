import 'package:flutter/foundation.dart';

class User {
  String uid;
  String name;
  String email;
  String profile;
  String phone;
  List<String> preferences;
  String bio;
  String gender;
  String aadhar;
  String usertype;
  Map<String, double> coordinates;

  User({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.profile,
    this.phone,
    this.preferences,
    this.bio,
    this.aadhar,
    this.gender,
    this.usertype,
    this.coordinates
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = uid;
    map['name'] = name;
    map['email'] = email;
    map['profile'] = profile;
    map['phone'] = phone ?? "";
    map['preferences'] = preferences ?? [];
    map['bio'] = bio ?? "";
    map['aadhar'] = aadhar ?? "";
    map['gender'] = gender ?? "";
    map['usertype'] = usertype ?? "";
    map['coordinates'] = coordinates ?? {};

    return map;
  }

}