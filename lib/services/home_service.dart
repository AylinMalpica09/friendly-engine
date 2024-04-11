import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Kiboowi/models/home_model.dart';

class HomeService {
  Future<List<HomeModel>> fetchhome(String token) async {
    print('Token recibido en HomeService: $token');
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    final response = await http.get(
      Uri.parse('http://137.184.115.48:1234/user-book/reading-books'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Response Data: $responseData'); // Imprimir la respuesta completa
      final List<dynamic> homeDataList = responseData['data']; // Cambio aquí para obtener una lista de datos
      // Mapeamos los datos de la lista a una lista de objetos HomeModel
      List<HomeModel> productList = homeDataList.map((homeData) {
        return HomeModel.fromJson({
          'id': homeData['id'],
          'idBook' : homeData['idBook'],
          'idUser' : homeData['idUser'] ,
          'bookName': homeData['bookName'],
          'authorName': homeData['authorName'],
          'imageUrl': homeData['imageUrl'],
        });
      }).toList();

      return productList;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
