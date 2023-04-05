import 'package:firebase_auth/firebase_auth.dart';
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
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () async {
                final userEmail = FirebaseAuth.instance.currentUser;
                await userEmail?.sendEmailVerification();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login/', (route) => false);
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Send email verification"))
        ],
      ),
    );
  }
}
