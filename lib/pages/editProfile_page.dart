import 'package:flutter/material.dart';
import 'package:Kiboowi/services/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyEditProfilePage extends StatefulWidget {
  final String token;

  const MyEditProfilePage({Key? key, required this.token}) : super(key: key);


  @override
  _MyEditProfilePageState createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {


  late TextEditingController passwordController;
  late String token;

  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController();
  }

  @override
  void dispose() {

    passwordController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    final String token = widget.token;
    final String password = passwordController.text;

    UpdateProfileService().updateProfile(
      token: token,
      password: password,
    ).then((_) {
      // Manejar el éxito de la actualización del perfil
      // Por ejemplo, mostrar un mensaje de éxito o navegar a otra pantalla
    }).catchError((error) {
      // Manejar errores de actualización del perfil
      print('Error updating profile: $error');
      // Por ejemplo, mostrar un diálogo de error o notificar al usuario
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Password'),
            TextField(controller: passwordController),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
