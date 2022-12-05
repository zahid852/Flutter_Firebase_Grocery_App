import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_grocery/models/store_model.dart';

class StoreSingleItem {
  String? storeItemId;
  final String name;
  final double price;
  final int quantity;
  StoreSingleItem(
      {required this.name,
      required this.price,
      required this.quantity,
      this.storeItemId});

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'quantity': quantity};
  }

  factory StoreSingleItem.fromSnapshot(QueryDocumentSnapshot doc) {
    return StoreSingleItem(
        name: doc['name'],
        price: doc['price'],
        quantity: doc['quantity'],
        storeItemId: doc.reference.id);
  }
}
