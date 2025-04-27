import 'package:recordatorio_aap/data/models/user_detail_reponse.dart';

class UserResponse {
  final List<UserDetailReponse> userDetailList;

  UserResponse({required this.userDetailList});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var list = json["users"] as List;
    List<UserDetailReponse> userList = list.map((user) => UserDetailReponse.fromJson(user)).toList();
    return UserResponse(userDetailList: userList);
  }
}