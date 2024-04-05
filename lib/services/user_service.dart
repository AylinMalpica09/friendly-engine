import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<void> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://137.184.115.48:1234/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if(response.statusCode == 200) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('user', jsonEncode(body));
    } else {
      throw Exception(body['message']);
    }
  }
}
