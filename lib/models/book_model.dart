class BookModel {
  final int id;
  final String bookName;
  final String authorName;
  final String initialDate;
  final String finishDate;
  final String notes;
  final String reaction;

  const BookModel({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.initialDate,
    required this.finishDate,
    required this.notes,
    required this.reaction,

  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'bookName': String bookName,
      'authorName': String authorName,
      'initialDate': String initialDate,
      'finishDate' : String finishDate,
      'notes': String notes,
      'reaction': String reaction,


      } => BookModel(
          id: id,
          bookName: bookName,
          authorName: authorName,
          initialDate: initialDate,
          finishDate: finishDate,
          notes: notes,
          reaction: reaction,
      ),
      _ => throw const FormatException('Failed to load book.'),
    };
  }
}
