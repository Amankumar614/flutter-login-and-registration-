import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
// import 'package:login/login.dart';
// import 'package:login/start.dart';
// import 'package:login/login.dart';
import 'package:login/start.dart';
import 'package:login/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "hello",
      theme: ThemeData(primaryColor: Colors.orange),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("old user");
              return welcome();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Somthing went wrong"),
              );
            } else {
              print("new user");
              return HomePage();
            }
          }),
    );
  }
}
