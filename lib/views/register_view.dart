import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/Animation/FadeAnimation.dart';

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
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900]!,
              Colors.orange[800]!,
              Colors.orange[400]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                      0.8,
                      const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  const SizedBox(height: 10),
                  FadeAnimation(
                      0.8,
                      const Text(
                        "Welcome to mynotes",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FadeAnimation(
                  2,
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(255, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10)),
                                ]),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: TextField(
                                    enableSuggestions: true,
                                    autocorrect: true,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _email,
                                    decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: _password,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Register if you don't have any account",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: TextButton(
                                onPressed: () async {
                                  final email = _email.text;
                                  final password = _password.text;
                                  try {
                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                    devtools.log(userCredential.toString());
                                  } on FirebaseAuthException catch (e) {
                                    devtools.log("Something bad happend");
                                    if (e.code == "email-already-in-use") {
                                      devtools.log(
                                          "Your email is already in use! Please use email that have not in use yet!");
                                    } else {
                                      devtools.log(e.code);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/login/", (route) => false);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
      // body: Container(
      //   decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //           colors: <Color>[Colors.yellowAccent, Colors.orange])),
      //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         "Register Page",
      //         style: TextStyle(fontSize: 25),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
      //         child: Column(
      //           children: [
      //             TextField(
      //               enableSuggestions: true,
      //               autocorrect: true,
      //               keyboardType: TextInputType.emailAddress,
      //               controller: _email,
      //               decoration: const InputDecoration(
      //                 hintText: "Email",
      //               ),
      //             ),
      //             TextField(
      //               obscureText: true,
      //               enableSuggestions: false,
      //               autocorrect: false,
      //               controller: _password,
      //               decoration: const InputDecoration(hintText: "Password"),
      //             )
      //           ],
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () async {
      //           final email = _email.text;
      //           final password = _password.text;
      //           try {
      //             final userCredential = await FirebaseAuth.instance
      //                 .createUserWithEmailAndPassword(
      //                     email: email, password: password);
      //             devtools.log(userCredential.toString());
      //           } on FirebaseAuthException catch (e) {
      //             devtools.log("Something bad happend");
      //             if (e.code == "email-already-in-use") {
      //               devtools.log(
      //                   "Your email is already in use! Please use email that have not in use yet!");
      //             }
      //           }
      //         },
      //         child: const Text("REGISTER"),
      //       ),
      //       ElevatedButton(
      //           onPressed: () {
      //             Navigator.of(context)
      //                 .pushNamedAndRemoveUntil("/login/", (route) => false);
      //           },
      //           child: const Text("Login"))
      //     ],
      //   ),
      // ),
    );
  }
}
