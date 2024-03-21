import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Kiboowi/pages/BookDetailsPage.dart';


class MyNewBook extends StatelessWidget {
  const MyNewBook({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookSearchPage(),
    );
  }
}

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Book> _books = [];

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

  void _viewBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Libros'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return ListTile(
                  onTap: () {
                    _viewBookDetails(book);
                  },
                  leading: book.imageUrl.isNotEmpty
                      ? Image.network(book.imageUrl)
                      : Icon(Icons.book),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final List<String> authors;
  final String imageUrl;

  Book({
    required this.title,
    required this.authors,
    required this.imageUrl,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    final List<String> authors = map['authors'] != null
        ? List<String>.from(map['authors'])
        : ['Desconocido'];

    String imageUrl = '';
    if (map.containsKey('imageLinks')) {
      final Map<String, dynamic> imageLinks = map['imageLinks'];
      if (imageLinks.containsKey('thumbnail')) {
        imageUrl = imageLinks['thumbnail'];
      }
    }

    return Book(
      title: map['title'] ?? 'Desconocido',
      authors: authors,
      imageUrl: imageUrl,
    );
  }
}