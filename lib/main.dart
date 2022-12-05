import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_grocery/firebase_options.dart';
import 'package:firestore_grocery/pages/store_list_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Grocery App",
        home: StoreListPage(),
        theme: ThemeData(primaryColor: Colors.green));
  }
}
