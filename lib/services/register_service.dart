import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<void> registerUser({
    required String name,
    required String username,
    required String email,
    required String password,
    required String birthday, // Corregido el nombre del campo
  }) async {
    print('Enviando datos al servidor:');
    print('Nombre: $name');
    print('Nombre de usuario: $username');
    print('Correo electrónico: $email');
    print('Contraseña: $password');
    print('Fecha de nacimiento: $birthday'); // Corregido el nombre del campo

    try {
      final response = await http.post(
        Uri.parse('http://137.184.115.48:1234/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'birthday': birthday, // Corregido el nombre del campo
        }),
      );

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuario registrado exitosamente: ${body['message']}');
      } else {
        print('Error al registrar el usuario: ${body['message']}');
        throw Exception(body['message']);
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
      throw Exception('Error al conectar con el servidor');
    }
  }
}