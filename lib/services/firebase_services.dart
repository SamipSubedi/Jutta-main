import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
  
  //String userId = _firebaseServices.getuser_id();
  //String Uri.parse(apiURL+"/${getuseid()}")

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
}
