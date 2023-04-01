import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifwEmailViewState();
}

class _VerifwEmailViewState extends State<VerifyEmailView> {
  final user = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Please verify your email address $user",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () async {
                final userEmail = FirebaseAuth.instance.currentUser;
                await userEmail?.sendEmailVerification();
                // FirebaseAuth.instance.signOut();
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login/", (route) => false);
              },
              child: const Text("Back to Login"))
        ],
      ),
    );
  }
}
