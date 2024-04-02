import 'dart:convert';
import 'package:Kiboowi/pages/BookDetailsPage.dart';
import 'package:http/http.dart' as http;
import 'package:Kiboowi/models/newbook_model.dart';

class NewBookService {
  Future<void> _searchBooks(String query) async {
    final String apiKey = 'AIzaSyDcHXlkT9pt57jqvq-bfEaMtZvr-aOzfPU';
    final String baseUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('items')) {
        final List<dynamic> items = data['items'];

        setState(() {
          _books = items
              .map((item) => Book.fromMap(item['volumeInfo']))
              .toList();
        });
      } else {
        setState(() {
          _books.clear();
        });
      }
    } else {
      print('Error al realizar la solicitud: ${response.statusCode}');
    }
  }
}