import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Autos.dart';
import 'package:proyecto/models/Brand.dart';
import 'dart:async';
import 'dart:convert';

Future<List<Autos>> fetchAutos() async {
  final response =
      await http.get(Uri.parse('https://romo.terrabyteco.com/api/Cars'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Autos> autos =
        jsonResponse.map((data) => Autos.fromJson(data)).toList();
    return autos;
  } else {
    throw Exception('Failed to load Autos');
  }
}

Future<Brand> fetchBrand(int brandId) async {
  final response = await http
      .get(Uri.parse('https://romo.terrabyteco.com/api/Brands/$brandId'));

  if (response.statusCode == 200) {
    Map<String, dynamic> brandData = jsonDecode(response.body);
    return Brand.fromJson(brandData);
  } else {
    throw Exception('Failed to load Brand');
  }
}

class AutosPage extends StatefulWidget {
  const AutosPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AutosPage> createState() => _AutosPageState();
}

class _AutosPageState extends State<AutosPage> {
  late Future<List<Autos>> futureAutos;

  @override
  void initState() {
    super.initState();
    futureAutos = fetchAutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.yellow.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Autos>>(
        future: futureAutos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
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
                      final auto = snapshot.data![index];
                      return AlertDialog(
                        title: Text('Detalles del Auto'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Id: ${auto.id}'),
                            Text('Nombre: ${auto.Nombre}'),
                            Text('Estado: ${auto.Estado}'),
                            FutureBuilder<Brand>(
                              future: fetchBrand(auto.Marca),
                              builder: (context, brandSnapshot) {
                                if (brandSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (brandSnapshot.hasError) {
                                  return Text('${brandSnapshot.error}');
                                } else {
                                  return Text(
                                      'Marca: ${brandSnapshot.data!.Nombre}');
                                }
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'Autos.png',
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
                          FutureBuilder<Brand>(
                            future: fetchBrand(snapshot.data![index].id),
                            builder: (context, brandsSnapshot) {
                              if (brandsSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (brandsSnapshot.hasError) {
                                return Text('${brandsSnapshot.error}',
                                    style: TextStyle(color: textColor));
                              } else {
                                return Row(
                                  children: [
                                    Text(
                                      'Marca: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      '${brandsSnapshot.data!.Nombre}',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                );
                              }
                            },
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
                            '${snapshot.data![index].Nombre}',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Estado: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '${snapshot.data![index].Estado}',
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
