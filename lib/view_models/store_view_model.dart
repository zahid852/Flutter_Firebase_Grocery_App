import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_grocery/models/store_model.dart';

class StoreViewModel {
  final Store store;
  StoreViewModel({required this.store});

  String get StoreId {
    return store.StoreId;
  }

  String get StoreName {
    return store.name;
  }

  String get StoreAdress {
    return store.address;
  }

  Future<int> get getItemsCount async {
    final itemsData = await store.documentReference!.collection('items').get();
    return itemsData.docs.length;
  }

  factory StoreViewModel.fromSnapshot(QueryDocumentSnapshot doc) {
    log('no');
    final store = Store.fromSnapshot(doc);
    return StoreViewModel(store: store);
  }
}
