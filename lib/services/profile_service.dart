import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:prueba_2/models/profile_model.dart';

class ProfileService {
  Future<List<ProfileModel>> fetchprofile() async {
    final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywibmFtZSI6IkthcmluZSBBbGNhemFyIFNhcm1pZW50byIsInVzZXJuYW1lIjoia2FyaWFsc2EiLCJlbWFpbCI6IjIxMzM0MEBkcy51cGNoaWFwYXMuZWR1Lm14IiwiYmlydGhkYXkiOiIyMDAyLTExLTI5IiwiY3JlYXRlRGF0ZSI6IjIwMjQtMDMtMTgiLCJpYXQiOjE3MTA4ODM1MjcsImV4cCI6MTcxMDg4NzEyN30.YKbDiI59UUkZtho4Gt4_cxMIdhUAXgsvRXO-4umderc";

    final response = await http.get(
      Uri.parse('http://127.0.0.1:1234/user/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      List<ProfileModel> profile = body.map(
            (profile) => ProfileModel.fromJson(
          {
            'id': profile['id'],
            'name': profile['name'],
            'username': profile['username'],
            'email': profile['email'],
            'birthday': profile['birthday'],
            'createDate': profile['createDate'],
          },
        ),
      ).toList();

      return profile;
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
