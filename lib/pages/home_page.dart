import 'package:flutter/material.dart';
import 'package:Kiboowi/models/home_model.dart';
import 'package:Kiboowi/services/home_service.dart';


class MyHomePage extends StatefulWidget {//widgets
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}


class _MyHomePageState extends State<MyHomePage> {
  late Future<HomeModel> futureHome; // Cambiar el tipo a Future<List<HomeModel>>

  TextEditingController nameBook = TextEditingController();
  TextEditingController authorBook = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    HomeService ps = HomeService();
    futureHome = ps.fetchhome();
  }


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
                  padding: EdgeInsets.only(left: 55), // Ajusta el margen izquierdo aquí
                  child: Text(
                    'Libros actuales',
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

                /*Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          /*_buildBookRow(
                            '${home.imageUrl}', '${home.bookName}', '${home.authorName}'
                          ),
                          _buildBookRow(
                              '${home.imageUrl}', '${home.bookName}', '${home.authorName}'
                          ),    */
                        ],
                      ),
                    ),
                  ),
                ),            */

                FutureBuilder<HomeModel>(
                  future: futureHome,
                  builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) { // Verifica si hay datos en el snapshot
                      return _buildBookRow(snapshot.data!); // Utiliza el método _buildBookRow y asegúrate de que snapshot.data no sea nulo
                    } else {
                      return Center(child: Text('No hay datos disponibles')); // Maneja el caso donde no hay datos
                    }
                  },
                )

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

  Widget _buildBookRow(HomeModel product) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.network(
              product.imageUrl, // Carga la imagen del libro desde la URL
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            product.bookName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            product.authorName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}