class UserDetails {
  final String username;
  final String password;
  final String? email;

  UserDetails({required this.username, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}