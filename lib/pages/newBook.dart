import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Kiboowi/pages/home_page.dart';
import 'package:Kiboowi/pages/book_page.dart';
import 'package:Kiboowi/models/newbook_model.dart';


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
        builder: (context) => MyBookPage(book: book),
      ),
    );
  }


  Color miColor = Color(0xFF4D5840);
  Color miB = Color(0xFFDDA15E);
  Color miC = Color(0xFF63843D);
  Color miW = Color(0xFFFAF5ED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
        color: miC.withOpacity(0.5), // Color del contenedor
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20), // Establece el margen horizontal
                    child: SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: 'login')),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: miColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0), // Padding para el TextField
            decoration: BoxDecoration(
              color: miW.withOpacity(0.5), // Color de fondo del Container
              borderRadius: BorderRadius.circular(10), // Bordes redondeados del Container
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Buscar Libro', // Texto que deseas mostrar
                  style: TextStyle(
                    color: miColor,
                    fontFamily: 'Manrope',
                    fontSize: 25,
                  ),
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Buscar',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: miColor),
                      onPressed: () {
                        _searchBooks(_controller.text);
                      },
                    ),
                    labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope'),
                    border: InputBorder.none, // Elimina el borde del TextField
                  ),
                  style: TextStyle(color: miColor, fontSize: 18),
                ),
              ],
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
                      : Icon(Icons.book, color: miColor,),
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