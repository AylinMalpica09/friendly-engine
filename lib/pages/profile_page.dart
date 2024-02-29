import 'package:flutter/material.dart';
import 'package:prueba_2/pages/initial_page.dart';
import 'package:prueba_2/pages/pending_page.dart'; //widgets

class MyProfilePage extends StatefulWidget {//widgets
  const MyProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  //state

  @override
  Widget build(BuildContext context) {
    Color bar = Color(0xFFDDA15E);
    return MaterialApp(

      home: Scaffold(
        body: Stack(
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
            Column(
              children: [
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
                SizedBox(height: 20), // Espacio entre la fila y el texto
                Text(
                  'Texto antes del contenedor',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20), // Espacio entre el texto y el contenedor
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20), // Ajusta los márgenes horizontalmente
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
                              Text(
                                '¡qqqq!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '¡sasa!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '¡a!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '¡s!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
                  //Navigator.pushNamed(context, '/');
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
                  Navigator.pushNamed(context, '/');
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