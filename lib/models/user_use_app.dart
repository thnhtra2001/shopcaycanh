class UserUseApp {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String address;
  final DateTime birthday;

  UserUseApp({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.address,
    required this.birthday,
  });

  UserUseApp copyWith({
    String? uid,
    String? name,
    String? phone,
    String? email,
    String? role,
    String? address,
    DateTime? birthday,
  }) {
    return UserUseApp(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
    );
  }

  // factory UserUseApp.fromJson(Map<dynamic, dynamic> json) {
  //   return UserUseApp(
  //     uid: json['uid'],
  //     name: json['name'],
  //     phone: json['phone'],
  //     email: json['email'],
  //     role: json['role'],
  //     address: json['address'],
  //     birthday:
  //     DateTime.parse(json['brithday']),
  //   );
  // }
    factory UserUseApp.fromJson(Map<dynamic, dynamic> json) {
    return UserUseApp(
      uid: json['uid'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      address: json['address'],
      birthday: 
      DateTime.now(),
      // json['brithday'],
    );
  }
}
