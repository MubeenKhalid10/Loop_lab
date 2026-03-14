
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<User?> registerWithEmail(String email, String password, String username, String role) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = cred.user!.uid;
    await _db.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'username': username,
      'role': role,
      'created_at': FieldValue.serverTimestamp(),
    });
    return cred.user;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    final res = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return res.user;
  }

  Future<void> signOut() async => _auth.signOut();
}
