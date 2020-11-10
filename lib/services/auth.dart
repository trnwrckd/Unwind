import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:therapy_zone/models/post.dart';
import 'package:therapy_zone/models/tag.dart';
import 'package:therapy_zone/models/user.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  final db = Firestore.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, isEmailverified: user.isEmailVerified)
        : null;
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      final verifiedEmail = user.isEmailVerified;
      if (verifiedEmail) {
        print('verifiedEmail ifblock');
        return _userFromFirebaseUser(user);
      } else {
        return "Please verify your email first";
      }
    } catch (e) {
      return e.message;
    }
  }

  //register with email & pass
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    try {
      await user.sendEmailVerification();
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = name;
      await user.updateProfile(updateUser);
      user.reload();
      await createUserTagInfo("", user.uid, 0, 0, 0, 0, 0, 0);
      //_userFromFirebaseUser(user)
      return " Please verify your email and log in again";
      //return user.uid;
    } catch (e) {
      return e.message;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e.message;
    }
  }

  Future postUpdate(
      String title, String desc, String mood, DateTime date) async {
    final uid = await getCurrentUID();
    Post post = Post(title, date, desc, mood);
    await db
        .collection("userData")
        .document(uid)
        .collection("posts")
        .add(post.toJson());
  }

  // adding code for chart
  final CollectionReference tagCollection =
      Firestore.instance.collection('tags');

  Future updateChartData(String tag, String uid) async {
    //print('$tag $uid');
    return await tagCollection.document(uid).setData({
      'lastFeeling': tag,
      'uid': uid,
    });
  }

  Future createUserTagInfo(String tag, String uid, int tag1, int tag2, int tag3,
      int tag4, int tag5, int tag6) async {
    print('done both');
    return await tagCollection.document(uid).setData({
      'lastFeeling': tag,
      'uid': uid,
      'tag1': tag1,
      'tag2': tag2,
      'tag3': tag3,
      'tag4': tag4,
      'tag5': tag5,
      'tag6': tag6,
    });
  }

  //ki je korlam ei jaygatay :| dukkhojonok

  Future actuallyUpdatehere(String tagnum, String lastFeeling) async {
    final uid = await getCurrentUID();
    final DocumentReference thisRef = tagCollection.document(uid);
    print("actually update here");
    return await thisRef.updateData(
        {'$tagnum': FieldValue.increment(1), 'lastFeeling': lastFeeling});
  }

  Future updateCounter(String feels) async {
    if (feels == "\u{1F616}") {
      await actuallyUpdatehere('tag1', feels);
    } else if (feels == "\u{1F62A}") {
      await actuallyUpdatehere('tag2', feels);
    } else if (feels == "\u{1F641}") {
      await actuallyUpdatehere('tag3', feels);
    } else if (feels == "\u{1F610}") {
      await actuallyUpdatehere('tag4', feels);
    } else if (feels == "\u{1F600}") {
      await actuallyUpdatehere('tag5', feels);
    } else if (feels == "\u{1F604}") {
      await actuallyUpdatehere('tag6', feels);
    }
  }

  List<Tag> _tagListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Tag(
          lastFeeling: doc.data['lastFeeling'] ?? '',
          tag1: doc.data['tag1'] ?? 0,
          tag2: doc.data['tag2'] ?? 0,
          tag3: doc.data['tag3'] ?? 0,
          tag4: doc.data['tag4'] ?? 0,
          tag5: doc.data['tag5'] ?? 0,
          tag6: doc.data['tag6'] ?? 0,
          uid: doc.data['uid'] ?? '');
    }).toList();
  }

  Stream<List<Tag>> get tags {
    return tagCollection.snapshots().map(_tagListFromSnapshot);
  }

  //RESETING PASSWORD
  Future<void> resetPassword(String email) async {
    //final email = (await _auth.currentUser()).email;
    print(email);
    await _auth.sendPasswordResetEmail(email: email);
  }
}
