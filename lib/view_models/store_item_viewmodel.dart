import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_grocery/models/store_Item_model.dart';
import 'package:firestore_grocery/models/store_model.dart';

class StoreItemViewModel {
  final StoreSingleItem storeItem;
  StoreItemViewModel({required this.storeItem}) {}
  String get name {
    return storeItem.name;
  }

  String get storeItemId {
    return storeItem.storeItemId ?? '';
  }

  factory StoreItemViewModel.fromSnapshot(QueryDocumentSnapshot doc) {
    final StoreItem = StoreSingleItem.fromSnapshot(doc);
    return StoreItemViewModel(storeItem: StoreItem);
  }
}
