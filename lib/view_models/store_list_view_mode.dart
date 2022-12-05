import 'package:cloud_firestore/cloud_firestore.dart';

class storeListViewmodel {
  Stream<QuerySnapshot>? get getList {
    return FirebaseFirestore.instance.collection('stores').snapshots();
  }
}
