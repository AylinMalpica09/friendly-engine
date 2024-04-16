import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateProfileService {
  Future<void> updateProfile({
    required String token,
    required String password,
  }) async {
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    try {
      final response = await http.put(
        Uri.parse('http://137.184.115.48:1234/user/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({

          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String message = responseData['message'];

        print('Profile updated: $message');
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage = errorData['message'];

        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error updating profile: $e');
      throw Exception('Error updating profile: $e');
    }
  }
}
