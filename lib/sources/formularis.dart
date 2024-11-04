import 'package:flutter/material.dart';

class Formularis extends StatelessWidget {
  const Formularis({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recuperar el valor d' 'un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Choose your option'),
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('SimpleDialog'),
                              //Controladores/es lo que hay dentro de un contenedor del flutter donde aqui puede ser una imagen
                              children: [
                                SimpleDialogOption(
                                  child: Text(myController.text),
                                )
                              ],
                            );
                          });
                    },
                    child: const Text('SimpleDialog'),
                  ),

                  //Next option
                  SimpleDialogOption(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Texto escrito'),
                              //contenido del texto
                              content: Text(myController.text),
                              //Como el row de flutter, solo pasa en la parte de abajo/ como un children
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Volver'))
                              ],
                            );
                          });
                    },
                    child: const Text('AlertDialog'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(myController.text),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    },
                    child: const Text('SnackBar'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.blueGrey,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(myController.text),
                                    ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Close BottomSheet'))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text('modalBottomSheet'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Mostra el valor!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
