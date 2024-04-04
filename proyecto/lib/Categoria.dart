import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/models/Brand.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({Key? key, required this.title, required this.Categoria})
      : super(key: key);

  final String title;
  final int Categoria;

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  late List<Brand> brands;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBrandsByCategory();
  }

  Future<void> fetchBrandsByCategory() async {
    try {
      final response = await http.get(Uri.parse(
          'https://romo.terrabyteco.com/api/Brands?Categoria=${widget.Categoria}'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Brand> filteredMarcas = responseData
            .map((data) => Brand.fromJson(data))
            .where((marca) =>
                marca.Categoria == widget.Categoria) // Filtrar marcas por marca
            .toList();

        setState(() {
          brands = filteredMarcas;
          loading = false;
        });
      } else {
        throw Exception('Failed to load marcas');
      }
    } catch (e) {
      print('Error fetching marcas: $e');
    }
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
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                final isEven = index.isEven;
                final cardColor =
                    isEven ? Colors.yellow.shade800 : Colors.blueGrey.shade900;
                final textColor =
                    isEven ? Colors.blueGrey.shade900 : Colors.yellow.shade800;

                return InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(8.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          children: [
                            Text(
                              'Id: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              '${brand.id}',
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
                              '${brand.Nombre}',
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
