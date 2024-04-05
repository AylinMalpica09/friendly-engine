import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Kiboowi/models/home_model.dart';

class HomeService {
  Future<List<HomeModel>> fetchhome() async {
    final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywibmFtZSI6IkthcmluZSBBbGNhemFyIFNhcm1pZW50byIsInVzZXJuYW1lIjoia2FyaWFsc2EiLCJlbWFpbCI6IjIxMzM0MEBkcy51cGNoaWFwYXMuZWR1Lm14IiwiYmlydGhkYXkiOiIyMDAyLTExLTI5IiwiY3JlYXRlRGF0ZSI6IjIwMjQtMDMtMTgiLCJpYXQiOjE3MTEwNDAwODEsImV4cCI6MTcxMTA0MzY4MX0.Fu0caCCNwoiZ9dndSsMPudTXB_Egnv3TwU50ofVfCfE';
    final response = await http.get(
      Uri.parse('http://137.184.115.48:1234/user/reading-books'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
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
