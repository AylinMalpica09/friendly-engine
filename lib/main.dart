import 'package:flutter/material.dart';
import 'package:prueba_2/pages/home_page.dart';
import 'package:prueba_2/pages/initial_page.dart';
import 'package:prueba_2/pages/library_page.dart';
import 'package:prueba_2/pages/pending_page.dart'; //widgets


void main() {

  runApp(const MyApp());
}
//stateless -> estatico
//statefull -> cambia por eventos
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/', // Especifica la ruta inicial de la aplicación
      routes: {
        '/': (context) => MyInitialPage(title: 'title'),
        '/home': (context) => MyHomePage(title: 'title'),
        '/pending': (context) => MyPendingPage(title: 'title'),
        '/library': (context) => MyLibraryPage(title: 'title'),
      },
    );
  }
}

