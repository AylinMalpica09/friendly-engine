import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Kiboowi/models/profile_model.dart';

class ProfileService {
  Future<ProfileModel> fetchProfile(String token) async {
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    final response = await http.get(
      Uri.parse('http://137.184.115.48:1234/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Map<String, dynamic> profileData = responseData['data'];

      final ProfileModel profile = ProfileModel.fromJson({
        'id': profileData['id'],
        'name': profileData['name'],
        'username': profileData['username'],
        'email': profileData['email'],
        'birthday': profileData['birthday'],
        'createDate': profileData['createDate'],
        'por_leer': profileData['books']['por_leer'].toString(),
        'leidos': profileData['books']['leidos'].toString(),
        'leyendo': profileData['books']['leyendo'].toString()
      });

      return profile;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
