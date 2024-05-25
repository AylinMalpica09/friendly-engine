import 'package:flutter/material.dart';
import 'package:Kiboowi/models/home_model.dart';
import 'package:Kiboowi/services/pending_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//213340@ds.upchiapas.edu.mx

class MyPendingPage extends StatefulWidget {//widgets
  const MyPendingPage({super.key, required this.title});
  final String title;

  @override
  State<MyPendingPage> createState() => _MyPendingPageState();
}

class _MyPendingPageState extends State<MyPendingPage> {
  late Future<List<HomeModel>> futureHome = Future.value([]);

  @override
  void initState() {
    super.initState();
    fetchHomeData();
  }
  Future<void> fetchHomeData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    print('Token recuperado de SharedPreferences: $token');

    if (token != null) {
      HomeService homeService = HomeService();
      setState(() {
        futureHome = homeService.fetchhome(token);
      });
    } else {
      // Si no hay un token almacenado, redirigir al usuario al inicio de sesión
      // o mostrar un mensaje de error
    }
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
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(left: 55), // Ajusta el margen izquierdo aquí
                  child: Text(
                    'Libros pendientes',
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
                SizedBox(height: 50),

                FutureBuilder<List<HomeModel>>(
                  future: futureHome,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      print("Libros obtenidos correctamente: ${snapshot.data}");
                      // Construye tus widgets utilizando los datos en snapshot.data
                      return Expanded(
                        child: GridView.count(
                          crossAxisCount: 2, // Muestra dos columnas
                          crossAxisSpacing: 5, // Espaciado horizontal entre elementos
                          mainAxisSpacing: 15, // Espaciado vertical entre elementos
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          children: snapshot.data!.map((book) {
                            return _buildBookRow(book);
                          }).toList(),
                        ),
                      );
                    }
                  },
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

  Widget _buildBookRow(HomeModel? product) {
    if (product == null) {
      return Container(); // O un widget alternativo o mensaje de error
    }

    return GestureDetector(
      onTap: () {
        _onBookClicked(product.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Image.network(
                product.imageUrl ?? '', // Verifica que imageUrls no sea null
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              product.bookName ?? '', // Verifica que bookName no sea null
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              product.authorName ?? '', // Verifica que authorName no sea null
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
    );
  }

  void _onBookClicked(int bookId) {
    // Aquí puedes realizar cualquier acción con el ID del libro, por ejemplo, abrir una nueva página
    print('Se hizo clic en el libro con ID: $bookId');
    // Puedes navegar a otra página y pasar el ID del libro como argumento
    Navigator.pushNamed(context, '/book_details', arguments: bookId);
  }

}

