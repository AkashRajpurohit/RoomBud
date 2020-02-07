import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:roombud/models/user.dart';
import 'package:roombud/services/database.dart';
import 'package:roombud/utils/shared_data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return User(
      name: user.displayName,
      email: user.email,
      profile: user.photoUrl,
      uid: user.uid,
      phone: user.phoneNumber ?? "0"
    );
  }

  Future<bool> signInWithGoogle() async {
    try {

      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);      
      final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken
      );

      final AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser user = result.user;

      User myUser = _userFromFirebase(user);

      final SharedData _data = SharedData();

      _data.addDataToSharedData("uid", myUser.uid);
      
      final DatabaseService _db = DatabaseService(uid: myUser.uid);

      DocumentSnapshot dbUser = await _db.getUser();

      if(dbUser.data == null) {
        await _db.addUserData(myUser.toMap());
      }

      return user != null;

    } catch(e) {
      print(e);
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

}