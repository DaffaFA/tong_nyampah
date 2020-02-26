import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference profileCollection = Firestore.instance.collection('profiles');

  Future updateProfilesData(String name, String classroom, String role) async {
    return await profileCollection.document(this.uid).setData({
      'name': name,
      'classroom': classroom != null ? classroom : null,
      'point': 0,
      'role': role != null ? role : 'user',
    });
  }
}