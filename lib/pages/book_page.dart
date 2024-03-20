import 'package:flutter/material.dart';
import 'package:prueba_2/pages/home_page.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  TextEditingController inicio = TextEditingController();
  TextEditingController fin = TextEditingController();
  TextEditingController nota = TextEditingController();
  TextEditingController reac = TextEditingController();

  Color miColor = Color(0xFF4D5840);
  Color miB = Color(0xFFDDA15E);
  Color miC = Color(0xFF63843D);
  Color miW = Color(0xFFFAF5ED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: miC.withOpacity(0.5),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Titulo',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 22,
                                      color: Color(0xFF283618),
                                    ),
                                  ),
                                  Text(
                                    'Autor',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 18,
                                      color: Color(0xFF283618),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                              color: Colors.grey, // Color gris
                              borderRadius: BorderRadius.circular(10.0), // Esquinas redondeadas con radio de 10.0
                            ), // Color gris
                            width: 103,
                            height: 203,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 50, // Tamaño del icono
                                color: Colors.white, // Color del icono
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: miW,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Fecha de lectura',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF283618),
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: inicio,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          labelText: 'Inicio',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: miColor),
                                          ),
                                          labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                                        ),
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: TextField(
                                        controller: fin,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          labelText: 'Fin',
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: miColor),
                                          ),
                                          labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                                        ),
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: nota,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: 'Nota',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: miColor),
                                    ),
                                    labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                                  ),
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: reac,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: 'Reacción',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: miColor),
                                    ),
                                    labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.emoji_emotions),
                                      onPressed: () {},
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Estatus:',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF283618),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    // Acción cuando se toca el botón "Seleccionar"
                                    _showPopupMenu(context); // Definir la función _showPopupMenu más adelante
                                  },
                                  child: IgnorePointer(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 50),
                                        height: 30,
                                        width: 250,
                                        child: TextField(
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(
                                            labelText: 'Seleccionar',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope',),
                                            suffixIcon: Icon(Icons.arrow_drop_down),
                                          ),
                                          style: TextStyle(color: Colors.black, fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: miB,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      'Guardar',
                                      style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Manrope'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'login')), // Navega a la vista LoginPage
                );
              },
              child: Padding(
                padding: EdgeInsets.all(1), // Ajusta el espacio alrededor del icono según sea necesario
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
                fixedSize: Size(20, 25),
              ),
            ),

          ),
        ],
      ),
    );
  }
  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1, 550, 0, 20),
      // Puedes ajustar la posición según tus necesidades
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text(
            'Leído',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF283618),
            ),
          ),
          value: 'opcion1',
        ),
        PopupMenuItem(
          child: Text(
            'Leyendo',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF283618),
            ),
          ),
          value: 'opcion2',
        ),
        PopupMenuItem(
          child: Text(
            'Por leer',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF283618),
            ),
          ),
          value: 'opcion3',
        ),
      ],
    ).then((value) {
      if (value != null) {
        // Acciones según la opción seleccionada
        print('Opción seleccionada: $value');
      }
    });
  }
}
