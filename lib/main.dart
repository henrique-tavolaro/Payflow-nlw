import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Material(
              child: Text(
            "Não foi possivel inicializar o Firebase",
            textDirection: TextDirection.ltr,
          ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
