import 'dart:developer';

import 'package:firestore_grocery/view_models/addStore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStorePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  void _saveStore(BuildContext context, _addStoreViewModel) async {
    if (_formKey.currentState!.validate()) {
      final isSaved = await _addStoreViewModel.saveStore();
      if (isSaved) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _addStoreViewModel = Provider.of<addStoreViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Add Store")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => _addStoreViewModel.name = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter store name"),
                ),
                TextFormField(
                  onChanged: (value) => _addStoreViewModel.storeAddress = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter store address"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _saveStore(context, _addStoreViewModel);
                  },
                ),
                Spacer(),
                Text(_addStoreViewModel.message)
              ],
            ),
          ),
        ));
  }
}
