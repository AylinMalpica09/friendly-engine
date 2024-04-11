import 'dart:convert';
import 'package:http/http.dart' as http;

class NewBookService {
  Future<void> newBooks({
    required String token, // Agregar token como parámetro
    required String authorName,
    required String bookName,
    required String imageUrl,
    required String initialDate,
    required String finishDate,
    required String notes,
    required String reaction,
    required int state,
    required String id,
  }) async {
    print('Enviando datos al servidor:');
    print('Id: $id');
    print('Autor: $authorName');
    print('Título: $bookName');
    print('Imagen: $imageUrl');
    print('Inicio: $initialDate');
    print('Fin: $finishDate');
    print('Nota: $notes');
    print('Reacción: $reaction');
    print('Estado: $state');

    try {
      final response = await http.post(
        Uri.parse('http://137.184.115.48:1234/user-book/add-book'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Usar el token pasado como parámetro
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'authorName': authorName,
          'bookName': bookName,
          'imageUrl': imageUrl,
          'initialDate': initialDate,
          'finishDate': finishDate,
          'notes': notes,
          'reaction': reaction,
          'state': state,
        }),
      );

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Datos Guardados: ${body['message']}');
      } else {
        print('Error al guardar datos: ${body['message']}');
        throw Exception(body['message']);
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
      throw Exception('Error al conectar con el servidor');
    }
  }
}
