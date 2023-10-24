class UserUseApp {
  final String userid;
  final String name;
  final String phone;
  final String email;
  final bool role;
  final String address;

  UserUseApp({
    required this.userid,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.address,
  });

  UserUseApp copyWith({
    String? userid,
    String? name,
    String? phone,
    String? email,
    bool? role,
    String? address,
  }) {
    return UserUseApp(
      userid: userid ?? this.userid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      address: address ?? this.address,
    );
  }
}
