import 'package:flutter/material.dart';
import 'package:prueba_2/home_page.dart'; //widgets

class MyLoginPage extends StatefulWidget {//widgets
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  //state

  @override
/*
  Widget build(BuildContext context) {
    Color colorFondo = Color(0xFFEFEFED);
    Color colorBoton1 = Color(0xFFDDA15E);
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget para la imagen de fondo
            Expanded(
              flex: 1, // Ocupa la mitad de la pantalla
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // Puedes añadir otros widgets dentro de este contenedor si lo necesitas
              ),
            ),
            // Widget para el título y los botones
            Expanded(
              flex: 1, // Ocupa la otra mitad de la pantalla
              child: Container(
                color: colorFondo, // Color de fondo
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Kiboowi',
                            style: TextStyle(
                              fontFamily: 'Montez',
                              fontSize: 48,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0), // Ajusta el espaciado según sea necesario
                          child: Image.asset(
                            'assets/img/logo.png', // Ruta de la imagen
                            width: 40, // Ancho de la imagen
                            height: 40, // Alto de la imagen
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 250, // Ancho máximo deseado para el texto
                      child: Text(
                        '¡Comencemos a descubrir otros mundos!',
                        textAlign: TextAlign.center, // Alinea el texto al centro
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35), // Ajusta el tamaño del botón
                        textStyle: TextStyle(fontSize: 20), // Ajusta el tamaño del texto del botón
                        backgroundColor: colorBoton1,
                      ),
                      child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Color(0xFFECF0F1),
                      ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35), // Ajusta el tamaño del botón
                        side: BorderSide(color: Color(0xFF283618)),
                        backgroundColor: colorFondo,
                        textStyle: TextStyle(
                            fontSize: 20,
                        ), // Ajusta el tamaño del texto del botón
                      ),
                      child: Text(
                          'Registrarse',
                        style: TextStyle(
                          color: Color(0xFF283618),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
  Widget build(BuildContext context) {
    Color colorBoton1 = Color(0xFF4D5840);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primera sección (fila) con un botón
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: 'login')), // Navega a la vista LoginPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),),
                        backgroundColor: colorBoton1,
                    ),
                    child: Icon(Icons.arrow_back,
                        color: Color(0xFFFEFAE0),
                    ),
                  ),
                ],
              ),
              // Segunda sección (fila) con un contenedor centrado que contiene botones
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Acción del primer botón
                          },
                          child: Text('Botón 2'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Acción del segundo botón
                          },
                          child: Text('Botón 3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}