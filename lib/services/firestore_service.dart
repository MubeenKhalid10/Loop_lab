
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> coursesStream() {
    return _db.collection('courses').orderBy('created_at', descending: true).snapshots();
  }

  Stream<QuerySnapshot> lessonsStream(String courseId) {
    return _db.collection('courses').doc(courseId).collection('lessons').orderBy('order').snapshots();
  }

  Stream<QuerySnapshot> announcementsStream() {
    return _db.collection('announcements').orderBy('published_at', descending: true).snapshots();
  }

  Stream<QuerySnapshot> eventsStream() {
    return _db.collection('events').orderBy('date', descending: true).snapshots();
  }
}
