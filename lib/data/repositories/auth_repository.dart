import 'dart:convert';
import 'package:gallery_app/core/constant.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthRepository {
  User? _currentUser;
  Future<User> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstant.logInUser),
        body: {
          'email': email,
          'password': password,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic extractedData = json.decode(response.body);
        print(extractedData);
        User user = User.fromJson(extractedData);
        _currentUser = user;
        return user;
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }

  Future<User> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser!;
    } else {
      throw Exception('User is not logged in');
    }
  }
}
