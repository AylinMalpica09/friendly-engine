import 'package:flutter/material.dart';
import 'package:Kiboowi/models/home_model.dart';
import 'package:Kiboowi/pages/home_page.dart';
import 'package:Kiboowi/pages/home_page.dart';
import 'package:Kiboowi/models/newbook_model.dart';
import 'package:http/http.dart' as http;
import 'package:Kiboowi/services/newbook_service.dart';


class MyBookPage extends StatefulWidget {
  final Book book;

  MyBookPage({required this.book});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}


class _MyBookPageState extends State<MyBookPage> {
  TextEditingController name = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController reaction = TextEditingController();
  TextEditingController status = TextEditingController();

  void saveBookData() {
    List<String> authors = widget.book.authors;
    String title = widget.book.title;
    String imageUrl = widget.book.imageUrl;

    author.text = authors.join(', ');
    name.text = title;
    image.text = imageUrl;
  }



  final Map<String, String> emojiReactions = {
    '❤️': 'Favorito',
    '💧': 'Triste',
    '🔥': '+18',
    '🤢': 'Disgusto',
  };


  String selectedEmoji = ''; // Variable para almacenar el emoji seleccionado


  Color miColor = Color(0xFF4D5840);
  Color miB = Color(0xFFDDA15E);
  Color miC = Color(0xFF63843D);
  Color miW = Color(0xFFFAF5ED);

  @override
  Widget build(BuildContext context) {
    saveBookData();
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20), // Ajusta el espacio horizontal según sea necesario
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // Esquinas redondeadas con radio de 10.0
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${widget.book.title}',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 22,
                                        color: Color(0xFF283618),
                                      ),
                                    ),
                                    SizedBox(height: 10), // Agrega un espacio vertical entre los textos
                                    Text(
                                      '${widget.book.authors.join(', ')}',
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
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                              // Color gris
                              borderRadius: BorderRadius.circular(10.0),
                            ), // Color gris
                            width: 103,
                            height: 250,
                            child: Center(
                              child: widget.book.imageUrl.isNotEmpty
                                  ? Image.network(
                                widget.book.imageUrl,
                                height: 250,
                              )
                                  : SizedBox(), //
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
                        height: 550,
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
                                        controller: start,
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
                                        controller: end,
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
                                  controller: note,
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
                                TextField(
                                  controller: reaction,
                                  readOnly: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelText: 'Reacción',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: miColor),
                                    ),
                                    labelStyle: TextStyle(color: miColor, fontFamily: 'Manrope'),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (selectedEmoji.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(right: 200.0,),
                                            child: Text(
                                              selectedEmoji,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        IconButton(
                                          icon: Icon(Icons.emoji_emotions),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 230,
                                                  child: Column(
                                                    children: emojiReactions.entries.map((entry) {
                                                      return ListTile(
                                                        leading: Icon(
                                                          _getIcon(entry.key),
                                                          color: _getIconColor(entry.key),
                                                        ),
                                                        title: Text(entry.value),
                                                        onTap: () {
                                                          _selectReaction(entry.key);
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }).toList(),
                                                  ),

                                                );

                                              },
                                            );
                                          },
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                //SizedBox(height: 10),
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
                                    onPressed: () async {
                                      try {
                                        final token = await NewBookService().newBooks(
                                          authorName: author.text,
                                          bookName: name.text,
                                          imageUrl: image.text,
                                          initialDate: start.text,
                                          finishDate: end.text,
                                          notes: note.text,
                                          reaction: reaction.text,
                                          state: status.text,
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyHomePage(title: 'home')),
                                        );
                                      } catch (e) {
                                        // Manejar el error aquí
                                        print('Error no se guardo: $e');
                                      }
                                    },
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
            child: SizedBox(
              width: 60, // Ancho del botón
              height: 40, // Alto del botón
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'login')), // Navega a la vista LoginPage
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: miColor, // Color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20, // Tamaño del icono
                  color: Colors.white,
                ),
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
      position: RelativeRect.fromLTRB(1, 550, 0, 1),
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
          value: 'Leído',
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
          value: 'Leyendo',
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
          value:'Por leer'
    ),
      ],
    ).then((value) {
      if (value != null) {
        // Acciones según la opción seleccionada
        print('Sección seleccionada: $value');
        setState(() {
          status.text = value.toString(); // Asignar la opción seleccionada a la variable
        });
      }
    });
  }



  void _selectReaction(String emoji) {
    setState(() {
      selectedEmoji = emoji; // Actualizar el emoji seleccionado
      reaction.text = emojiReactions[emoji] ?? ''; // Actualizar el nombre de la reacción en el controlador
    });
    print("Reacción seleccionada: ${emojiReactions[selectedEmoji]}");
  }

  IconData _getIcon(String emoji) {
    switch (emoji) {
      case '❤️':
        return Icons.favorite_sharp;
      case '💧':
        return Icons.water_drop_rounded;
      case '🔥':
        return Icons.local_fire_department_rounded;
      case '🤢':
        return Icons.sentiment_very_dissatisfied_rounded;
      default:
        return Icons.emoji_emotions;
    }
  }

  // Método para obtener el color correspondiente al emoji
  Color _getIconColor(String emoji) {
    switch (emoji) {
      case '❤️':
        return Colors.red;
      case '💧':
        return Colors.cyan;
      case '🔥':
        return Colors.orange;
      case '🤢':
        return Colors.lightGreen;
      default:
        return Colors.black;
    }
  }
}
