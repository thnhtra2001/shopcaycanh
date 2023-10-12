class AuthToken {
  final String _token;
  final String _userId;
  final DateTime _expiryDate;
  late String _role = "user";

  AuthToken({
    token,
    userId,
    expiryDate,
  })  : _token = token,
        _userId = userId,
        _expiryDate = expiryDate;

  bool get isValid {
    return token != null;
  }

  set role (String newRole){
    _role = newRole;
  }

  String get role{
    return _role;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      userId: json['userId'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}