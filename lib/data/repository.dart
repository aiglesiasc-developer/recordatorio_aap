import 'dart:convert';

import 'package:recordatorio_aap/data/models/user_details.dart';
import 'package:recordatorio_aap/data/models/user_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<UserResponse?> fechUserInfoByUsername(String username) async {
    final response = await http.get(
      Uri.parse("http://192.168.1.47/api/users/username/$username"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      UserResponse userResponse = UserResponse.fromJson(decodedJson);
      return userResponse;
    } else {
      return null;
    }
  }

  Future<UserResponse?> fechUserInfoById(String id) async {
    final response = await http.get(
      Uri.parse("http://192.168.1.47/api/users/$id"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      UserResponse userResponse = UserResponse.fromJson(decodedJson);
      return userResponse;
    } else {
      return null;
    }
  }

  Future<UserResponse?> fechUserInfoByEmail(String email) async {
    final response = await http.get(
      Uri.parse("http://192.168.1.47/api/users/email/$email"),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      UserResponse userResponse = UserResponse.fromJson(decodedJson);
      return userResponse;
    } else {
      return null;
    }
  }

  void registerUser(UserDetails user) async {
    final response = await http.post(
      Uri.parse("http://192.168.1.47:3000/api/users/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('Usuario registrado correctamente');
      print(response.body);
    } else {
      print('Error al registrar usuario: ${response.statusCode}');
      print(response.body);
    }
  }

  Future<Map<String, dynamic>> checkUserExist(
    String username,
    String email
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.1.47:3000/api/users/check?username=$username&email=$email',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Error al comprobar usuario');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return {
        'usernameExists': false,
        'emailExists': false,
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> loginUser(UserDetails user) async {
    final response = await http.post(
      Uri.parse("http://192.168.1.47:3000/api/users/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('Usuario logeado correctamente');
      print(response.body);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print('Error al registrar usuario: ${response.statusCode}');
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
  }
}

class UserDetail {}
