import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Kiboowi/models/profile_model.dart';
import 'package:Kiboowi/services/profile_service.dart';
import 'package:Kiboowi/services/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Kiboowi/pages/editProfile_page.dart';
import 'package:Kiboowi/services/delete_service.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<ProfileModel>? futureProfile;
  late String token; // Variable para almacenar el token

  @override
  void initState() {
    super.initState();
    fetchProfile(); // Llama al método para obtener el perfil
  }

  Future<void> fetchProfile() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token') ?? '';
    print('Token recuperado de SharedPreferences: $token');

    if (token.isNotEmpty) {
      ProfileService profileService = ProfileService();

      setState(() {
        futureProfile =
            profileService.fetchProfile(token); // Pasa el token al servicio
      });
    } else {
      // Manejo de caso en el que no hay token
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Color miColor = Color(0xFF4D5840);
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    Color bar = Color(0xFFDDA15E);

    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<ProfileModel>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras se carga el perfil, muestra un indicador de carga
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si hay un error al obtener el perfil, muestra un mensaje de error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Una vez que se obtiene el perfil, muestra los datos
              ProfileModel profile = snapshot.data!;
              name.text = profile.name;
              date.text = profile.birthday;
              email.text = profile.email;

              return Stack(
                children: [
                  // Fondo de pantalla
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/perfil.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Contenido
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 55, top: 20),
                        child: Text(
                          'Mi perfil',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 28,
                            color: Color(0xFF283618),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 8),
                        child: Image.asset(
                          'assets/icons/vector.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 100), // Espacio entre la fila y el texto
                        Text(
                          'Te uniste: ${profile.createDate}',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 16), // Espacio entre el texto y el contenedor
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10), // Ajusta los márgenes horizontalmente
                                width: 350,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SingleChildScrollView(
                                  reverse: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Datos personales',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      EditableTextField(
                                        controller: name,
                                        label: 'Nombre',
                                        hintText: 'mi nombre es tal',
                                        labelTextColor: miColor,
                                        enabled: isEditing,
                                      ),
                                      EditableTextField(
                                        controller: date,
                                        label: 'Fecha de nacimiento',
                                        hintText: 'xx/xx/xxxx',
                                        labelTextColor: miColor,
                                        enabled: isEditing,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Cuenta',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      EditableTextField(
                                        controller: email,
                                        label: 'Correo electrónico',
                                        labelTextColor: miColor,
                                        hintText: 'hola@mundo.com',
                                        enabled: isEditing,
                                      ),
                                      EditableTextField(
                                        controller: password,
                                        label: 'Contraseña',
                                        hintText: '*********',
                                        labelTextColor: miColor,
                                        enabled: isEditing,
                                        obscureText: true,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyEditProfilePage(token: token), // Pasa el token aquí
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: bar,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Editar perfil',
                                              style: TextStyle(
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Mi recuento de libros',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 400,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Libros leídos:',
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10), // Espacio de 10 píxeles entre los dos Containers
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          profile.leidos,
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 400,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Libros leyendo:',
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10), // Espacio de 10 píxeles entre los dos Containers
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          profile.leyendo,
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 400,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          'Libros por leer:',
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10), // Espacio de 10 píxeles entre los dos Containers
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          profile.por_leer,
                                          textAlign: TextAlign.center, // Alinea el texto al centro
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              ElevatedButton(
                                onPressed: () async {
                                  // Mostrar un diálogo de confirmación antes de eliminar la cuenta
                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('¿Estás seguro de que deseas eliminar tu cuenta?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false); // Cierra el diálogo y devuelve false
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true); // Cierra el diálogo y devuelve true
                                            },
                                            child: Text('Eliminar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // Si el usuario confirmó la eliminación de la cuenta, procede con la operación
                                  if (confirmDelete == true) {
                                    // Crear una instancia de AccountService
                                    AccountService accountService = AccountService();

                                    // Realizar la eliminación de la cuenta
                                    bool deleteSuccess = await accountService.deleteAccount(token);

                                    // Aquí puedes manejar el resultado de la eliminación, por ejemplo:
                                    if (deleteSuccess) {
                                      // Si la cuenta se eliminó con éxito, puedes realizar alguna acción, como navegar a la pantalla de inicio
                                      Navigator.of(context).pushNamed('/home');
                                    } else {
                                      // Si hubo un error al eliminar la cuenta, puedes mostrar un mensaje de error
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Error al eliminar la cuenta. Inténtalo de nuevo más tarde.'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: miColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Eliminar cuenta',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              backgroundColor: bar,
              icon: Padding(
                padding: const EdgeInsets.only(top: 10), // Ajusta el margen superior aquí
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                    //Navigator.pushNamed(context, '/pending');
                  },
                  child: Image.asset(
                    'assets/icons/home.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pending');
                },
                child: Image.asset(
                  'assets/icons/pending.png',
                  width: 24,
                  height: 24,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Image.asset(
                  'assets/icons/salida.png',
                  width: 24,
                  height: 24,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/library');
                },
                child: Image.asset(
                  'assets/icons/books.png',
                  width: 24,
                  height: 24,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Image.asset(
                  'assets/icons/profile.png',
                  width: 24,
                  height: 24,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class EditableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool enabled;
  final bool obscureText;
  final Color? labelTextColor;

  const EditableTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.enabled = false,
    this.labelTextColor,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelStyle: TextStyle(color: labelTextColor),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 15),
    );
  }
}
