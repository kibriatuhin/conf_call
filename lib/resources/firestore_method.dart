import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firestore
      .collection("userDetails")
      .doc(_firebaseAuth.currentUser!.uid)
      .collection("meetings")
      .snapshots();

  void addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection("userDetails")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("meetings")
          .add({"meetingName": meetingName, "createdAt": DateTime.now()});
    } catch (e) {
      print(e);
    }
  }
}
