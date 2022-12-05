import 'package:firestore_grocery/view_models/store_item_viewmodel.dart';
import 'package:flutter/material.dart';

class StoreItemsWidget extends StatelessWidget {
  final List<StoreItemViewModel> ItemList;
  final void Function(StoreItemViewModel) onStoreItemDeleted;
  StoreItemsWidget({required this.ItemList, required this.onStoreItemDeleted});

  Widget _buildItems(BuildContext context, int index) {
    final StoreItem = ItemList[index];
    return Dismissible(
      key: Key(StoreItem.storeItemId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (_) {
        onStoreItemDeleted(StoreItem);
      },
      child: ListTile(
        title: Text(StoreItem.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ItemList.length,
      itemBuilder: _buildItems,
    );
  }
}
