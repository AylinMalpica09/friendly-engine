import 'package:flutter/material.dart';
import 'package:prueba_2/pages/initial_page.dart'; //widgets

class MyPendingPage extends StatefulWidget {//widgets
  const MyPendingPage({super.key, required this.title});

  final String title;

  @override
  State<MyPendingPage> createState() => _MyPendingPageState();
}

class _MyPendingPageState extends State<MyPendingPage> {
  //state

  @override
  Widget build(BuildContext context) {
    Color bar = Color(0xFFDDA15E);
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/homePage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Contenido
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 55),
                  // Margen izquierdo para el texto
                  child: Text(
                    'Próximas lecturas',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 25,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Alineación horizontal centrada
                  children: [
                    Container(
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Buscar...',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Espacio entre el buscador y la sección de libros
                // Sección de libros con desplazamiento
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          _buildBookRow(
                              'assets/img/verano.png', 'Hasta que el verano se acabe', 'Connor Hamilton',
                              'assets/img/red.png', 'Red Queen', 'Victoria Aveyard'
                          ),
                          _buildBookRow(
                              'assets/img/atlas.png', 'Atlas de Geografía Universal', 'Educación primaria',
                              'assets/img/tronos.png', 'Juego de tronos', 'George R.R. Martin'
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildBookRow(String imagePath1, String title1, String author1, String imagePath2, String title2, String author2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // Primer libro
          Expanded(
            child: Column(
              children: [
                // Imagen del primer libro
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.asset(
                    imagePath1,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                // Título del primer libro
                Text(
                  title1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Autor del primer libro
                Text(
                  author1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16), // Espacio entre los libros
          // Segundo libro
          Expanded(
            child: Column(
              children: [
                // Imagen del segundo libro
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.asset(
                    imagePath2,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                // Título del segundo libro
                Text(
                  title2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Autor del segundo libro
                Text(
                  author2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}