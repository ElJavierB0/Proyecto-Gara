import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Remplacement.dart';

import 'dart:async';
import 'dart:convert';

Future<List<Remplacement>> fetchRemplacements() async {
  final response = await http
      .get(Uri.parse('https://romo.terrabyteco.com/api/Remplacements'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Remplacement> remplacements =
        jsonResponse.map((data) => Remplacement.fromJson(data)).toList();
    return remplacements;
  } else {
    throw Exception('Failed to load Remplacements');
  }
}

class RemplacementPage extends StatefulWidget {
  const RemplacementPage({super.key, required this.title});

  final String title;

  @override
  State<RemplacementPage> createState() => _RemplacementPageState();
}

class _RemplacementPageState extends State<RemplacementPage> {
  late Future<List<Remplacement>> futureRemplacements;

  @override
  void initState() {
    super.initState();
    futureRemplacements = fetchRemplacements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.yellow.shade800),
        ),
      ),
      body: FutureBuilder<List<Remplacement>>(
        future: futureRemplacements,
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
                                    'Tipo: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data![index].type),
                                  Spacer(),
                                  Text(
                                    'Precio: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${snapshot.data![index].price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Descripción: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].description,
                                      style: TextStyle(),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
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
                                  ElevatedButton(
                                    onPressed: () {
                                      // Muestra un nuevo AlertDialog indicando que se ha agregado el producto
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Producto agregado'),
                                            content: Text(
                                                'El producto se ha agregado correctamente.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Cierra el nuevo AlertDialog
                                                },
                                                child: Text('Aceptar'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Agregar'),
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
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'Taller.jpeg',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Id: ${snapshot.data![index].id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data![index].name),
                          Text(snapshot.data![index].type),
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
