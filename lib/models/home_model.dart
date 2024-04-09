class HomeModel {
  final int id;
  final String idBook;
  final int idUser;
  final String bookName;
  final String authorName;
  final String imageUrl; // Cambiado a una lista de String para las URLs de las imágenes

  const HomeModel({
    required this.id,
    required this.idBook,
    required this.idUser,
    required this.bookName,
    required this.authorName,
    required this.imageUrl,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json
      ) {
    return HomeModel(
      id: json['id'] as int,
      idBook: json['idBook'] as String,
      idUser: json['idUser'] as int,
      bookName: json['bookName'] as String, // Corregido el nombre del campo
      authorName: json['authorName'] as String,
      imageUrl: json['imageUrl'], // Convertir la lista de JSON a una lista de String
    );
  }
}