import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String name;
  final String address;
  DocumentReference? documentReference;
  Store({required this.name, required this.address, this.documentReference});
  String get StoreId {
    return documentReference!.id;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'address': address};
  }

  factory Store.fromSnapshot(QueryDocumentSnapshot doc) {
    return Store(
        name: doc['name'] ?? '',
        address: doc['address'] ?? '',
        documentReference: doc.reference);
  }
}
