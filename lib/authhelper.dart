import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "role": "customer",
    };

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
    } else {
      await userRef.set(userData);
    }
  }
}
