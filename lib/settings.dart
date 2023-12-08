import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:harmonix/auth/sign_in.dart';
import 'package:harmonix/utils/globals.dart';
import 'package:harmonix/utils/methods.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              highlightColor: transparent,
              splashColor: transparent,
              hoverColor: transparent,
              onTap: () async {
                try {
                  showSnack("User Signed-Out", 1, context);
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const SignIn()), (Route route) => route.isFirst);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  showSnack(e.toString(), 3, context);
                }
              },
              child: AnimatedContainer(
                duration: 700.ms,
                decoration: BoxDecoration(color: teal, borderRadius: BorderRadius.circular(12)),
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(20),
                child: const Center(child: Text("Sign Out", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
