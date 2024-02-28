import 'package:flutter/material.dart';
import 'package:prueba_2/initial_page.dart'; //widgets


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

        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //debugShowCheckedModeBanner: false,
      home: const MyInitialPage(title: 'Flutter Demo Home Page'),
    );
  }
}

