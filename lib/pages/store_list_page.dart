import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_grocery/pages/add_store_page.dart';
import 'package:firestore_grocery/pages/store_item_list_page.dart';
import 'package:firestore_grocery/utils/constants.dart';
import 'package:firestore_grocery/view_models/addStore_view_model.dart';
import 'package:firestore_grocery/view_models/store_list_view_mode.dart';
import 'package:firestore_grocery/view_models/store_view_model.dart';
import 'package:firestore_grocery/widgets/empty_results_widget.dart';
import 'package:firestore_grocery/widgets/item_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreListPage extends StatefulWidget {
  @override
  _StoreListPage createState() => _StoreListPage();
}

class _StoreListPage extends State<StoreListPage> {
  storeListViewmodel _listViewmodel = storeListViewmodel();
  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: _listViewmodel.getList,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return _buildList(snapshot.data);
          } else {
            return EmptyResultsWidget(
              message: Constants.NO_STORES_FOUND,
            );
          }
        });
  }

  Widget _buildList(QuerySnapshot? snapshot) {
    final stores = snapshot?.docs
            .map((docItem) => StoreViewModel.fromSnapshot(docItem))
            .toList() ??
        [];
    return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildListItem(store, (store) {
            _navigatorToAddStoreItem(context, store);
          });
        });
  }

  void _navigatorToAddStoreItem(
      BuildContext context, StoreViewModel store) async {
    final reload =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StoreItemListPage(store: store);
    }));

    if (reload) {
      setState(() {});
    }
  }

  Widget _buildListItem(
      StoreViewModel store, void Function(StoreViewModel) onStoreSelected) {
    return ListTile(
        title: Text(
          store.StoreName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(store.StoreAdress),
        trailing: FutureBuilder<int>(
            future: store.getItemsCount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ItemCountWidget(
                  count: snapshot.data,
                );
              } else {
                return SizedBox.shrink();
              }
            }),
        onTap: () {
          onStoreSelected(store);
        });
  }

  void _navigatorToAddStorePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) {
                    return addStoreViewModel();
                  },
                  child: AddStorePage(),
                ),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Grocery App"),
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
              onTap: () {
                _navigatorToAddStorePage(context);
              },
            )
          ],
        ),
        body: _buildBody());
  }
}
