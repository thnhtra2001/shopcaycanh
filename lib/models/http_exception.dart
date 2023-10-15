class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.firebase(String code)
      : message = _translateFirebaseErrorCode(code);

  static String _translateFirebaseErrorCode(code) {
    switch (code) {
      case 'EMAIL_EXISTS':
        return 'This email address is already in use';
      case 'INVALID_EMAIL':
        return 'This is not a valid email address';
      case 'WEAK_PASSWORD':
        return 'This password is too weak';
      case 'EMAIL_NOT_FOUND':
        return 'Could not find a user with that email';
      case 'INVALID_PASSWORD':
        return 'Invalid password';
      default:
        return code;
    }
  }

  @override
  String toString() {
    return message;
  }
}
