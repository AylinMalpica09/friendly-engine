class ProfileModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String birthday;
  final String createDate;
  final String por_leer;
  final String leidos;
  final String leyendo;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.birthday,
    required this.createDate,
    required this.por_leer,
    required this.leidos,
    required this.leyendo,

  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'name': String name,
      'username': String username,
      'email': String email,
      'birthday' : String birthday,
      'createDate': String createDate,
      'por_leer': String por_leer,
      'leidos': String leidos,
      'leyendo': String leyendo

      } => ProfileModel(
        id: id,
        name: name,
        username: username,
        email: email,
        birthday: birthday,
        createDate: createDate,
        por_leer: por_leer,
        leidos: leidos,
        leyendo: leyendo

      ),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}
