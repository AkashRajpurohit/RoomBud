import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });

  // Collection reference
  final CollectionReference _userCollection = Firestore.instance.collection("users");

  Future getUser() async {
    try {
      return await _userCollection.document(uid).get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addUserData(Map<String, dynamic> data) async {
    try {
      var userExists = await getUser();
      if(userExists.data != null) {
        await _userCollection.document(uid).updateData(data);
      } else {
        await _userCollection.document(uid).setData(data);
      }
    } catch (e) {
      print(e);
    }
  }



}