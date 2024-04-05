import 'package:flutter/material.dart';
import 'package:proyecto/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Usuario>> fetchUsuarios() async {
  final response =
      await http.get(Uri.parse('https://romo.terrabyteco.com/api/Users'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Usuario> remplacements =
        jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    return remplacements;
  } else {
    throw Exception('Failed to load Remplacements');
  }
}

class PersonaPage extends StatefulWidget {
  const PersonaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PersonaPage> createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  late Future<List<Usuario>> futureUsuarios;

  @override
  void initState() {
    super.initState();
    futureUsuarios = fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900, // Color del fondo
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.yellow.shade800), // Color del texto
        ),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No hay datos disponibles');
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final isEven = index.isEven;
              final cardColor =
                  isEven ? Colors.yellow.shade800 : Colors.blueGrey.shade900;
              final textColor =
                  isEven ? Colors.blueGrey.shade900 : Colors.yellow.shade800;
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text("Detalles de Remplacements"),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'Taller.jpeg',
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Id: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].id.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nombre: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapshot.data![index].Nombre} ${snapshot.data![index].Apellido}',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Email),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Celular: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Celular),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Status: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Status.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nivel: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].Nivel.toString()),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Lógica para cerrar el AlertDialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cerrar'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'Piezas.png',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Id: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].id}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nombre: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Nombre} ${snapshot.data![index].Apellido}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Email: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Email}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Celular: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Celular}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Status}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nivel: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].Nivel}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
