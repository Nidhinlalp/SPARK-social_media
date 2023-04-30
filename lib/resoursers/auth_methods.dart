import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spark/model/user.dart' as model;
import 'package:spark/resoursers/sotrage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _frestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _frestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snapshot);
  }

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'some error occurred';
    try {
      if (email.isNotEmpty ||
          password.isEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //add user to  data base

        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          email: email,
          uid: credential.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _frestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //login in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
