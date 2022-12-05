import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_grocery/models/store_Item_model.dart';
import 'package:firestore_grocery/view_models/store_item_viewmodel.dart';
import 'package:firestore_grocery/view_models/store_view_model.dart';

class StoreItemListViewmodel {
  String name = '';
  double price = 0.0;
  int quantity = 0;
  final StoreViewModel store;
  StoreItemListViewmodel({required this.store});
  Stream<QuerySnapshot> get storeItemStream {
    return FirebaseFirestore.instance
        .collection('stores')
        .doc(store.StoreId)
        .collection('items')
        .snapshots();
  }

  void deleteStoreItem(StoreItemViewModel storeItem) {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(store.StoreId)
        .collection('items')
        .doc(storeItem.storeItemId)
        .delete();
  }

  void saveStoreItem() {
    final storeItem =
        StoreSingleItem(name: name, price: price, quantity: quantity);
    FirebaseFirestore.instance
        .collection('stores')
        .doc(store.StoreId)
        .collection('items')
        .add(storeItem.toMap());
  }
}
