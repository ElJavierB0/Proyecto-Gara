import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Service.dart';

import 'dart:async';
import 'dart:convert';

Future<List<Servicios>> fetchServicios() async {
  final response =
      await http.get(Uri.parse('https://romo.terrabyteco.com/api/Services'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Servicios> servicios =
        jsonResponse.map((data) => Servicios.fromJson(data)).toList();
    return servicios;
  } else {
    throw Exception('Failed to load Services');
  }
}

class ReparacionesPage extends StatefulWidget {
  const ReparacionesPage({super.key, required this.title});

  final String title;

  @override
  State<ReparacionesPage> createState() => _ReparacionesPageState();
}

class _ReparacionesPageState extends State<ReparacionesPage> {
  late Future<List<Servicios>> futureServicios;

  @override
  void initState() {
    super.initState();
    futureServicios = fetchServicios();
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
      body: FutureBuilder<List<Servicios>>(
        future: futureServicios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No hay datos disponibles');
          }

          // Filtrar la lista de servicios por Tipo "Reparacion"
          List<Servicios> serviciosFiltrados = snapshot.data!
              .where((servicio) => servicio.Tipo.toLowerCase() == 'reparacion')
              .toList();

          return ListView.builder(
            itemCount: serviciosFiltrados.length,
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
                          child: Text("Detalles de la Reparación"),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                'https://images.pexels.com/photos/3846390/pexels-photo-3846390.jpeg?auto=compress&cs=tinysrgb&w=600',
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
                                  Text(serviciosFiltrados[index].id.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Nombre: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(serviciosFiltrados[index].Nombre),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Tipo: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(serviciosFiltrados[index].Tipo),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Descripcion: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(serviciosFiltrados[index].Descripcion),
                                ],
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para cerrar el AlertDialog
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cerrar'),
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
                      Image.network(
                        'https://images.pexels.com/photos/3846390/pexels-photo-3846390.jpeg?auto=compress&cs=tinysrgb&w=600',
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
                                '${serviciosFiltrados[index].id}',
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
                                '${serviciosFiltrados[index].Nombre}',
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Tipo: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${serviciosFiltrados[index].Tipo}',
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
