import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  Firestore _firestore = Firestore.instance;

  Future<void> setStatusRedeem(String docId, String status) async {
    final uuid = Uuid().v4();

    await _firestore.collection('gifts_redeem').document(docId).updateData({
      "status": status,
      "code": uuid,
    });
  }

  Future<void> decreasePoint(String uid, String docId) async {
    print(docId);
    DocumentSnapshot _gift =
        await _firestore.collection('gifts').document(docId).get();
    DocumentSnapshot _user =
        await _firestore.collection('profiles').document(uid).get();

    await _firestore.collection('profiles').document(uid).updateData({
      "point": _user.data["point"] - _gift.data["point"],
    });

    await _firestore.collection('point_history').document().setData({
      "user_uid": uid,
      "point_after": _user.data["point"] - _gift.data["point"],
      "point_before": _user.data["point"],
      "created_at": DateTime.now()
    });
  }

  Future<void> cancelRedeem(String docId) async {
    await _firestore.collection('gifts_redeem').document(docId).delete();
  }

  Future<void> createNewReport(
      {String image, String type, String title, String description}) async {
    try {
      await _firestore.collection('reports').document().setData({
        "image": image,
        "user_uid": this.uid,
        "type": type,
        "title": title != null ? title : 'Capture',
        "description": description != null
            ? description
            : 'No description, it\'s was capture type',
        "status": "waiting",
      });
    } catch (e) {
      print(e.toString());
    }
  }

  DatabaseService({this.uid});

  Future createReportClaim({String docId, String uid}) {
    return _firestore.collection('gifts_redeem').document().setData({
      "gifts_uid": docId,
      "status": 'waiting',
      "user_uid": uid,
      "code": null,
    });
  }

  Future createNewGifts(
      {String image, String title, String description, int point}) async {
    return await _firestore.collection('gifts').document().setData({
      "image": image,
      "title": title,
      "description": description,
      "point": point
    });
  }

  Future createNewBlog({String image, String title, String description}) async {
    return await _firestore.collection('blog').document().setData({
      "image": image,
      "title": title,
      "description": description,
      "created_at": Timestamp.now()
    });
  }

  Future editProfile({String name, String classroom}) async {
    return await _firestore.collection('profiles').document(uid).updateData({
      "name": name,
      "classroom": classroom,
    });
  }

  Stream<DocumentSnapshot> getReportByDocId(docId) {
    return _firestore.collection('reports').document(docId).snapshots();
  }

  Stream<QuerySnapshot> getAllWaitingGiftList(uid) {
    return _firestore
        .collection('gifts_redeem')
        .where('user_uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllWaitingGift() {
    return _firestore.collection('gifts_redeem').snapshots();
  }

  Stream<QuerySnapshot> getAllGift() {
    return _firestore.collection('gifts').snapshots();
  }

  Stream<QuerySnapshot> getAllPost() {
    return _firestore.collection('blog').snapshots();
  }

  Future<void> setStatusReport(docId, status, type, uid) async {
    final int point = type == 'capture' ? 10 : type == 'recycle' ? 30 : 15;
    final _user = _firestore.collection('profiles').document(uid);
    int pointBefore;

    await _user.get().then((val) {
      pointBefore = val["point"];
    });

    await _firestore.collection('reports').document(docId).updateData({
      "status": status,
    });

    if (status == 'confirmed') {
      await _firestore.collection('point_history').document().setData({
        "point_before": pointBefore,
        "point_after": pointBefore + point,
      });

      await _user.updateData({
        "point": pointBefore + point,
      });
    }
  }

  Future<DocumentSnapshot> getGiftByDocId(docId) {
    return _firestore.collection('gifts').document(docId).get();
  }

  Future<DocumentSnapshot> getRedeemByDocId(docId) {
    return _firestore.collection('gifts_redeem').document(docId).get();
  }

  Stream<QuerySnapshot> getAllReport() {
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
