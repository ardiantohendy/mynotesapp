import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerivied;
  const AuthUser(this.isEmailVerivied);

  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
