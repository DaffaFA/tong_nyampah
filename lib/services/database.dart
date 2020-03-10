import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  Firestore _firestore = Firestore.instance;

  Future<void> createNewReport({
    String image,
    String type,
    String title,
    String description,
  }) async {
    try {
      await _firestore.collection('reports').document().setData({
        "image": image,
        "user_uid": this.uid,
        "type": type,
        "title": title != null ? title : '',
        "description": description != null ? description : '',
        "status": "waiting",
      });
    } catch (e) {
      print(e.toString());
    }
  }

  DatabaseService({this.uid});

  Stream<QuerySnapshot> getAllReport()  {
    return _firestore.collection('reports').snapshots();
  }

  Future<DocumentSnapshot> getReportByUid(uid) {
    return _firestore.collection('reports').document(uid).get();
  }

  Future<DocumentSnapshot> getProfileData() async {
    return await _firestore.collection('profiles').document(this.uid).get();
  }

  Future<QuerySnapshot> getAllDocument() async {
    return await _firestore.collection('profiles').getDocuments();
  }

  Future createNewProfile(String name) async {
    try {
      await _firestore.collection('profiles').document(this.uid).setData(
          {"classroom": null, "name": name, "point": 0, "role": "user"});
    } catch (e) {
      print(e.toString());
    }
  }
}
