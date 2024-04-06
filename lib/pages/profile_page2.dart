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
                              SizedBox(height: 20), // Espacio entre el texto y el contenedor
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
                                          setState(() {
                                            isEditing = !isEditing;
                                          });
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
                                              isEditing ? 'Guardar cambios' : 'Editar perfil',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Libros leídos:',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                      '2', // Aquí puedes poner el número de libros leídos
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Libros leyendo:',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '20', // Aquí puedes poner el número de libros leídos
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Libros por leer:',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '20', // Aquí puedes poner el número de libros leídos
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                  Navigator.pushNamed(context, '/books');
                },
                child: Image.asset(
                  'assets/icons/add.png',
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
