import 'package:flutter/material.dart';
import 'package:Kiboowi/pages/home_page.dart';
import 'package:Kiboowi/pages/initial_page.dart';
import 'package:Kiboowi/services/register_service.dart'; // Asegúrate de importar el servicio

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController datebirth = TextEditingController();

  Color miColor = Color(0xFF4D5840);
  Color miB = Color(0xFFDDA15E);
  Color colorFondo = Color(0xFFEFEFED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con la imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/registro.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Botón de regreso
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyInitialPage(title: 'login')), // Navega a la vista LoginPage
                );
              },
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: miColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Contenido central
          Container(
            margin: EdgeInsets.only(top: 100,left: 50),
            width: 300,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '¡Regístrate!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Nombre completo',
                      prefixIcon: Icon(Icons.sort_by_alpha, color: miColor, size: 20),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelStyle: TextStyle(color: miColor, fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15, fontFamily: 'Manrope',),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      prefixIcon: Icon(Icons.person, color: miColor, size: 20),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(color: miColor, fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15, fontFamily: 'Manrope',),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email, color: miColor, size: 20),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(color: miColor, fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15, fontFamily: 'Manrope',),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.password, color: miColor,size: 20),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      labelStyle: TextStyle(color: miColor, fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15, fontFamily: 'Manrope',),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: datebirth,
                    decoration: InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      prefixIcon: Icon(Icons.calendar_month, color: miColor, size: 20),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(color: miColor, fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15, fontFamily: 'Manrope',),
                  ),
                ],
              ),
            ),
          ),
          // Botón de registro fuera del contenedor para que no se vea afectado por el scroll
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: ElevatedButton(
                onPressed: () async {
                  print('Nombre: ${name.text}');
                  print('Nombre de usuario: ${username.text}');
                  print('Correo electrónico: ${email.text}');
                  print('Contraseña: ${password.text}');
                  print('Fecha de nacimiento: ${datebirth.text}');
                  // Llamar al método de registro del servicio aquí
                  try {
                    await RegisterService().registerUser(
                      name: name.text,
                      username: username.text,
                      email: email.text,
                      password: password.text,
                      birthday: datebirth.text,
                    );
                    // Registro exitoso, puedes navegar a la página de inicio de sesión o hacer lo que necesites aquí
                  } catch (e) {
                    // Manejar el error aquí
                    print('Error durante el registrosss: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: miB,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Registrarse',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/img/kiwi.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}