import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Page",
              style: TextStyle(fontSize: 25),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Column(
                children: [
                  TextField(
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _password,
                    decoration: const InputDecoration(hintText: "Password"),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);
                  print(userCredential);
                  final userLogin = FirebaseAuth.instance.currentUser?.email;
                  if (userLogin != false) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/main/', (route) => false);
                  }
                } on FirebaseAuthException catch (e) {
                  print("Something bad happend");
                  if (e.code == "user-not-found") {
                    print("User not found! maybe you have not registered yet");
                  } else if (e.code == "wrong-password") {
                    print("Incorect password");
                  }
                }
              },
              child: const Text("LOGIN"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/register/", (route) => false);
                },
                child: Text("Register an email"))
          ],
        ),
      ),
    );
  }
}
