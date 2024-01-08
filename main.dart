import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'subject_page.dart';
import 'result_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDFQHIRIjElWLnZ_1P-uzIWXOX3hXvLmi0",
        authDomain: "rhtdrth.firebaseapp.com",
        projectId: "rhtdrth",
        storageBucket: "rhtdrth.appspot.com",
        messagingSenderId: "896043178181",
        appId: "1:896043178181:web:016e4fecaef866cee5b8ac"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String subject = "Mathematics";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Page2(), // Page 1
        '/page3': (context) => Page3(
            average: 0.0,
            grade: 'A'), // Gantilah nilai default sesuai kebutuhan Anda
      },
    );
  }
}
