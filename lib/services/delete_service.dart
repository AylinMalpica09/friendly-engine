import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {


  Future<bool> deleteAccount(String token) async {
    try {

      final response = await http.delete(
        Uri.parse('http://137.184.115.48:1234/user/delete'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Si la eliminación de la cuenta se realizó con éxito en el servidor
        return true;
      } else {
        // Si la eliminación de la cuenta falló en el servidor
        print('Error al eliminar la cuenta en el servidor: ${response.body}');
        return false;
      }
    } catch (error) {
      // Maneja cualquier error que pueda ocurrir durante la eliminación de la cuenta
      print('Error al eliminar la cuenta: $error');
      return false;
    }
  }
}
