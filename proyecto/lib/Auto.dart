import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/models/Autos.dart';
import 'package:proyecto/models/Brand.dart';

class AutoPage extends StatelessWidget {
  final int autoId;
  const AutoPage({Key? key, required this.autoId, required this.title})
      : super(key: key);
  final String title;

  Future<Autos> fetchAutos(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/Cars/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> autosData = jsonDecode(response.body);
      return Autos.fromJson(autosData);
    } else {
      throw Exception('Failed to load Car');
    }
  }

  Future<Brand> fetchBrand(int brandid) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/Brands/$brandid'));

    if (response.statusCode == 200) {
      Map<String, dynamic> brandData = jsonDecode(response.body);
      return Brand.fromJson(brandData);
    } else {
      throw Exception('Failed to load Brand');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Auto'),
      ),
      body: FutureBuilder<Autos>(
        future: fetchAutos(autoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No hay datos disponibles'));
          }

          Autos selectedAuto = snapshot.data!;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.asset(
                    'Taller.jpeg',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${selectedAuto.Nombre}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      FutureBuilder<Brand>(
                        future: fetchBrand(selectedAuto.id),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (userSnapshot.hasError) {
                            return Text('${userSnapshot.error}');
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  '${selectedAuto.id}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${selectedAuto.Estado}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FutureBuilder<Brand>(
                                  future: fetchBrand(userSnapshot.data!.id),
                                  builder: (context, specialistSnapshot) {
                                    if (specialistSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (specialistSnapshot.hasError) {
                                      return Text(
                                          '${specialistSnapshot.error}');
                                    } else {
                                      return Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Text(
                                            'Carro: ${userSnapshot.data!.Nombre} ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
