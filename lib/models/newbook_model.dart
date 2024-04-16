class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.imageUrl,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    //final String id= map['id'];
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
      id: map['id'] ?? 'Desconocido',
      title: map['title'] ?? 'Desconocido',
      authors: authors,
      imageUrl: imageUrl,
    );
  }
}