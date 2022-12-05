import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_grocery/models/store_model.dart';
import 'package:flutter/cupertino.dart';

class addStoreViewModel with ChangeNotifier {
  String name = '';
  String storeAddress = '';
  String message = '';

  Future<bool> saveStore() async {
    bool isSaved = false;
    final store = Store(name: name, address: storeAddress);
    try {
      await FirebaseFirestore.instance.collection('stores').add(store.toMap());
      isSaved = true;
      message = 'data saved successfully';
    } on Exception catch (error) {
      message = 'Unable to store the data';
    } catch (error) {
      message = 'Error occured';
    }
    notifyListeners();
    return isSaved;
  }
}
