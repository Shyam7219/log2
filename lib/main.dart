import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:log2/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<FirebaseApp> _InitializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: FutureBuilder(
        future: _InitializeFirebase(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.done) {
            return Login();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    )
    );
  }
}

