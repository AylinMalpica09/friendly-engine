import 'package:flutter/material.dart';
import 'package:Kiboowi/services/update_profile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late TextEditingController nameController;
  late TextEditingController birthdayController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    birthdayController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthdayController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    final String token = 'your_token_here'; // Obtén el token de donde lo almacenes
    final String name = nameController.text;
    final String birthday = birthdayController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    UpdateProfileService().updateProfile(
      token: token,
      name: name,
      birthday: birthday,
      email: email,
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
            Text('Name'),
            TextField(controller: nameController),
            SizedBox(height: 16.0),
            Text('Birthday'),
            TextField(controller: birthdayController),
            SizedBox(height: 16.0),
            Text('Email'),
            TextField(controller: emailController),
            SizedBox(height: 16.0),
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
