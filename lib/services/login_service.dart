import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  Future<String> loginUser(String email, String password) async {
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
      //print("Inicio de sesión exitoso: ${body['message']}");

      // Extraer el token del cuerpo de la respuesta
      final String token = body['token'];
      //print('Token recibido del servidor: $token');

      // Almacenar el token en SharedPreferences
      //print('Token recibido para guardar: $token');
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', token);
      print('Token guardado en SharedPreferences.');

      return token; // Devolver el token

    } else {
      print("Error al iniciar sesión: ${body['message']}");
      throw Exception(body['message']);
    }
  }
}
