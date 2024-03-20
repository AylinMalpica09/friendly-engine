import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:prueba_2/models/profile_model.dart';

class ProfileService {
  Future<ProfileModel> fetchprofile() async {
    final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywibmFtZSI6IkthcmluZSBBbGNhemFyIFNhcm1pZW50byIsInVzZXJuYW1lIjoia2FyaWFsc2EiLCJlbWFpbCI6IjIxMzM0MEBkcy51cGNoaWFwYXMuZWR1Lm14IiwiYmlydGhkYXkiOiIyMDAyLTExLTI5IiwiY3JlYXRlRGF0ZSI6IjIwMjQtMDMtMTgiLCJpYXQiOjE3MTA4OTY0MTAsImV4cCI6MTcxMDkwMDAxMH0.U8RRMFfe0YkoP2xDBe3L0oJTsGcWbw1ntqPQXE1gbdg";

    final response = await http.get(
      Uri.parse('http://127.0.0.1:1234/user/profile'),
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
      });

      return profile;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
