class UserDetailReponse {
  final String username;
  final String password;
  final String email;

  UserDetailReponse({required this.username, required this.password, required this.email});

  factory UserDetailReponse.fromJson(Map<String, dynamic> json){
    return UserDetailReponse(username: json["username"], password: json["password"], email: json["email"]);
  }
}