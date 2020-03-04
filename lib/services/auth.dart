import 'package:tongnyampah/models/Profile.dart';
import 'package:tongnyampah/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tongnyampah/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  Future<User> getUserData() async {
    FirebaseUser user = await _auth.currentUser();
    return _userFromFirebase(user);
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(this._userFromFirebase);
  }

  Future registerEmailAndPassword(
      String name, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).createNewProfile(name);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print(user);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
