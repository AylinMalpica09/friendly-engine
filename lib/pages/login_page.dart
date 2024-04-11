import 'package:flutter/material.dart';
import 'package:Kiboowi/pages/home_page.dart';
import 'package:Kiboowi/pages/initial_page.dart';
import 'package:Kiboowi/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogInPage extends StatefulWidget {
  const MyLogInPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLogInPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLogInPage> {
  String error = "";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                image: AssetImage('assets/img/login.png'),
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
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100), // Ajusta según sea necesario
              width: 300,
              height: 500,
              padding: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '¡Bienvenido!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Resto del contenido del formulario
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email, color: miColor),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: miColor), // Color del borde cuando el TextField no está enfocado
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.password, color: miColor),
                      fillColor: colorFondo,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                    ),
                    style: TextStyle(color: miColor, fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                  ),
                  // Botón de registro
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserService userService = UserService();
                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        final String? token = sharedPreferences.getString('token');
                        if (token != null) {
                          await userService.loginUser(email.text, password.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: 'title')),
                          );
                        } else {
                          // Manejar el caso donde no se pudo obtener el token
                        }
                      } catch(e) {
                        setState(() {
                          error = e.toString();
                        });
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
                          'Iniciar sesión',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
