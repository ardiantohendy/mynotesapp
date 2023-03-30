import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text("Register Page"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register Page",
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
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  print("Something bad happend");
                  if (e.code == "email-already-in-use") {
                    print(
                        "Your email is already in use! Please use email that have not in use yet!");
                  }
                }
              },
              child: const Text("REGISTER"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login/", (route) => false);
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
