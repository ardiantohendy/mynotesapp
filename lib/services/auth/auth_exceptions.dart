// LOGIN EXCEPTIONS

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// REGISTER EXPECTIONS

class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//GENERIC EXCEPTIONS

class GenericAuthException implements Exception {}

class UserNotLogginAuthException implements Exception {}
