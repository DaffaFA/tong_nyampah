import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tongnyampah/services/database.dart';

class Report {
  final String image;
  final String title;
  final String userUid;
  final String description;
  final String type;

  Report({this.description, this.image, this.title, this.type, this.userUid});

  static Stream<QuerySnapshot> getAllReport() {
    return DatabaseService().getAllReport();
  }
}
