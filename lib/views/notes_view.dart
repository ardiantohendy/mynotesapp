import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../alert/alert_dialog.dart';
import '../constant/routes.dart';
import '../enums/menu_actions.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: const Text(
          "MyNotes",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginView, (route) => false);
                }
                break;
              case MenuAction.notes:
                await showErrorDialog(context, "You dont have any note yet!");
            }
            // devtools.log(value.toString());
            // showLogOutDialog(context);
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text("Logout")),
              PopupMenuItem<MenuAction>(
                  value: MenuAction.notes, child: Text("My Notes"))
            ];
          })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Colors.orange[900]!,
            Colors.orange[800]!,
            Colors.orange[400]!,
          ],
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "This is a content",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure want to sign out?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  "Cancle",
                  style: TextStyle(color: Colors.grey),
                )),
            ElevatedButton(
                onPressed: () {
                  AuthService.firebase().logOut();
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      }).then((value) => value ?? false);
}

// Future<void> showNotesDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("You dont have any notes"),
//           content: const Text("Please add new notes if you don't have any"),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: const Text(
//                   "Ok",
//                   style: TextStyle(color: Colors.white),
//                 ))
//           ],
//         );
//       });
// }
