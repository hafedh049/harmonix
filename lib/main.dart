import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonix/auth/sign_in.dart';
import 'package:harmonix/home.dart';
import 'package:harmonix/utils/globals.dart';
import 'package:harmonix/utils/methods.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder(
        future: load(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FirebaseAuth.instance.currentUser == null ? const SignIn() : const Home();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator(color: blue)));
          } else {
            return Scaffold(body: Center(child: Text(snapshot.error.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))));
          }
        },
      ),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
