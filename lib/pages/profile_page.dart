import 'package:flutter/material.dart';
import 'package:Kiboowi/models/profile_model.dart';
import 'package:Kiboowi/services/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<ProfileModel> futureProfile;
  late String token; // Variable para almacenar el token

  @override
  void initState() {
    super.initState();
    fetchProfile(); // Llama al método para obtener el perfil
  }

  // Método para obtener el perfil del usuario
  Future<void> fetchProfile() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token') ?? ''; // Obtiene el token de SharedPreferences
    print('Token recuperado de SharedPreferences: $token');

    if (token.isNotEmpty) {
      ProfileService profileService = ProfileService();
      setState(() {
        futureProfile = profileService.fetchProfile(token); // Pasa el token al servicio
      });
    } else {
      // Manejo de caso en el que no hay token
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
      ),
      body: Center(
        child: FutureBuilder<ProfileModel>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildProfile(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  // Método para construir la UI del perfil
  Widget buildProfile(ProfileModel profile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${profile.name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Ajusta el estilo según tus preferencias
          ),
          Text(
            'Username: ${profile.username}',
            style: TextStyle(fontSize: 16, color: Colors.black87), // Ajusta el estilo según tus preferencias
          ),
          Text(
            'Email: ${profile.email}',
            style: TextStyle(fontSize: 16, color: Colors.black87), // Ajusta el estilo según tus preferencias
          ),
          Text(
            'Birthday: ${profile.birthday}',
            style: TextStyle(fontSize: 16, color: Colors.black87), // Ajusta el estilo según tus preferencias
          ),
          Text(
            'Create Date: ${profile.createDate}',
            style: TextStyle(fontSize: 16, color: Colors.black87), // Ajusta el estilo según tus preferencias
          ),
          Text(
            'Te uniste: ${profile.createDate}',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

}
