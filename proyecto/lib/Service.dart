import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Service.dart';

import 'dart:async';
import 'dart:convert';

Future<List<Servicios>> fetchServicios() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Services'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Servicios> servicios =
        jsonResponse.map((data) => Servicios.fromJson(data)).toList();
    return servicios;
  } else {
    throw Exception('Failed to load Services');
  }
}

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key, required this.title});

  final String title;

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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

          // Filtrar la lista de servicios por Tipo "Servicio"
          List<Servicios> serviciosFiltrados = snapshot.data!
              .where((servicio) => servicio.Tipo.toLowerCase() == 'servicio')
              .toList();

          return ListView.builder(
            itemCount: serviciosFiltrados.length,
            itemBuilder: (context, index) {
              final isEven = index.isEven;
              final cardColor =
                  isEven ? Colors.blueGrey.shade900 : Colors.yellow.shade800;
              final textColor =
                  isEven ? Colors.yellow.shade800 : Colors.blueGrey.shade900;

              return InkWell(
                onTap: () {},
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
                        'Taller.jpeg',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(height: 8),
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
                      SizedBox(height: 8),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
