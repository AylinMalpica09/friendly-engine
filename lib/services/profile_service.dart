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
      final bool hasBooksData = profileData['books'] is Map<String, dynamic>;

      final ProfileModel profile = ProfileModel.fromJson({
        'id': profileData['id'],
        'name': profileData['name'],
        'username': profileData['username'],
        'email': profileData['email'],
        'birthday': profileData['birthday'],
        'createDate': profileData['createDate'],
        'por_leer': hasBooksData ? profileData['books']['por_leer'].toString() : '0',
        'leidos': hasBooksData ? profileData['books']['leidos'].toString() : '0',
        'leyendo': hasBooksData ? profileData['books']['leyendo'].toString() : '0',
      });

      return profile;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
