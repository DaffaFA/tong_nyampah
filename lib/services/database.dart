import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  Firestore _firestore = Firestore.instance;
  


  DatabaseService({this.uid});
  // Profile _convertToProfile(DocumentSnapshot documentSnapshot) {
  //   return documentSnapshot != null ? Profile(classroom: documentSnapshot.documentID)
  // }

  Future<DocumentSnapshot> getProfileData() async {
    return await _firestore.collection('profiles').document(this.uid).get();
  }

  Future<QuerySnapshot> getAllDocument() async {
    return await _firestore.collection('profiles').getDocuments();
  }

  Future createNewProfile(String name) async {
    try {
      await _firestore.collection('profiles').document(this.uid).setData({
        "classroom": null,
        "name": name,
        "point": 0,
        "role": "user"
      });
    } catch(e) {
      print(e.toString());
    }
  }

}