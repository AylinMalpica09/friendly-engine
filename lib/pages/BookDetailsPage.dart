import 'package:flutter/material.dart';
import 'package:prueba_2/pages/newBook.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Libro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (book.imageUrl.isNotEmpty)
              Image.network(
                book.imageUrl,
                height: 200,
              ),
            SizedBox(height: 20),
            Text(
              'Título: ${book.title}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Autor(es): ${book.authors.join(', ')}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}