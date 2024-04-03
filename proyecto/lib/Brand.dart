import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/Brand.dart';
import 'package:proyecto/models/Category.dart';
import 'Autos.dart';
import 'dart:async';
import 'dart:convert';

Future<List<Brand>> fetchBrands() async {
  final response =
      await http.get(Uri.parse('https://romo.terrabyteco.com/api/Brands'));

  if (response.statusCode == 200) {
    Iterable jsonResponse = jsonDecode(response.body);
    List<Brand> brands =
        jsonResponse.map((data) => Brand.fromJson(data)).toList();
    return brands;
  } else {
    throw Exception('Failed to load Brands');
  }
}

Future<Category> fetchCategory(int categoryId) async {
  final response = await http.get(
      Uri.parse('https://romo.terrabyteco.com/api/Categories/$categoryId'));

  if (response.statusCode == 200) {
    Map<String, dynamic> categoryData = jsonDecode(response.body);
    return Category.fromJson(categoryData);
  } else {
    throw Exception('Failed to load category');
  }
}

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  late Future<List<Brand>> futureBrands;

  @override
  void initState() {
    super.initState();
    futureBrands = fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.yellow.shade800, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Brand>>(
        future: futureBrands,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AutosPage(title: 'Autos'),
                    ),
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
                        'Taller.jpeg',
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
                          FutureBuilder<Category>(
                            future: fetchCategory(snapshot.data![index].id),
                            builder: (context, categorySnapshot) {
                              if (categorySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (categorySnapshot.hasError) {
                                return Text(
                                  '${categorySnapshot.error}',
                                  style: TextStyle(color: textColor),
                                );
                              } else {
                                return Row(
                                  children: [
                                    Text(
                                      'Categoria: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      '${categorySnapshot.data!.Tipo}',
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
