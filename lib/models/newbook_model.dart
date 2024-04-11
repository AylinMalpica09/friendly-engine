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

  factory Book.fromMap(String id, Map<String, dynamic> map) {
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
      id: id,
      title: map['title'] ?? 'Desconocido',
      authors: authors,
      imageUrl: imageUrl,
    );
  }
}
