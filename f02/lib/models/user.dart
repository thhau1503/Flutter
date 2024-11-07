class User {
  final String username;
  final String email;
  final String phone;
  final String address;

  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}