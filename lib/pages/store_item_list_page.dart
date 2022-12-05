import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_grocery/view_models/storeItemListViewmodel.dart';
import 'package:firestore_grocery/view_models/store_item_viewmodel.dart';
import 'package:firestore_grocery/view_models/store_list_view_mode.dart';
import 'package:firestore_grocery/view_models/store_view_model.dart';
import 'package:firestore_grocery/widgets/store_items_widget.dart';
import 'package:flutter/material.dart';

class StoreItemListPage extends StatelessWidget {
  final StoreViewModel store;
  late StoreItemListViewmodel _storeItemListViewmodel;
  StoreItemListPage({required this.store}) {
    _storeItemListViewmodel = StoreItemListViewmodel(store: store);
  }
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return "Field cannot be empty";
    }

    // return '';
  }

  void _saveStoreItem() {
    if (_formKey.currentState!.validate()) {
      _storeItemListViewmodel.name = _nameController.text;
      _storeItemListViewmodel.price = double.parse(_priceController.text);
      _storeItemListViewmodel.quantity = int.parse(_quantityController.text);
      _storeItemListViewmodel.saveStoreItem();
      _clearTextBoxes();
    }
  }

  void _clearTextBoxes() {
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
  }

  Widget _buildStoreItems() {
    return StreamBuilder<QuerySnapshot>(
        stream: _storeItemListViewmodel.storeItemStream,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Text('No data added');
          }
          final stores = snapshot.data!.docs
              .map((storeItem) => StoreItemViewModel.fromSnapshot(storeItem))
              .toList();
          return StoreItemsWidget(
              ItemList: stores,
              onStoreItemDeleted: (storeItem) {
                _storeItemListViewmodel.deleteStoreItem(storeItem);
              });
        }));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _nameController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter store item"),
          ),
          TextFormField(
            controller: _priceController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter price"),
          ),
          TextFormField(
            controller: _quantityController,
            validator: _validate,
            decoration: InputDecoration(hintText: "Enter quantity"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text("Save", style: TextStyle(color: Colors.white)),
            onPressed: () {
              _saveStoreItem();
            },
          ),
          Expanded(child: _buildStoreItems())
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(store.StoreName),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )),
        body: _buildBody());
  }
}
