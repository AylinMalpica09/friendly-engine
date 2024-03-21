class ProfileModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String birthday;
  final String createDate;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.birthday,
    required this.createDate,

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

      } => ProfileModel(
        id: id,
        name: name,
        username: username,
        email: email,
        birthday: birthday,
        createDate: createDate,

      ),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}
