import 'package:flutter/material.dart';
import 'package:mynotes/constant/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifwEmailViewState();
}

class _VerifwEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Check your email for verifycation!",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const Text(
              "If you haven't receive email verifycation, please the button bellow"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
            onPressed: () {
              AuthService.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginView, (route) => false);
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }
}
