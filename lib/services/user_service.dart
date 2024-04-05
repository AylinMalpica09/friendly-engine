import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  Future<void> loginUser(String email, String password) async {
    print("Realizando solicitud HTTP...");
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
    print("Respuesta recibida: ${response.body}");


    final Map<String, dynamic> body = jsonDecode(response.body);

    if(response.statusCode == 200) {
      print("Inicio de sesión exitoso: ${body['message']}");


      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('user', jsonEncode(body));
    } else {
      print("Error al conectar a la base de datos: ${body['message']}");

      throw Exception(body['message']);
    }
  }
}