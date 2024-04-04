import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto/models/Autos.dart';

class MarcaPage extends StatefulWidget {
  const MarcaPage({Key? key, required this.title, required this.Marca})
      : super(key: key);

  final String title;
  final int Marca;

  @override
  State<MarcaPage> createState() => _MarcaPageState();
}

class _MarcaPageState extends State<MarcaPage> {
  List<Autos> autos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAutossByBrand();
  }

  Future<void> fetchAutossByBrand() async {
    try {
      final response = await http.get(Uri.parse(
          'https://romo.terrabyteco.com/api/Cars?Marca=${widget.Marca}'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Autos> filteredAutos = responseData
            .map((data) => Autos.fromJson(data))
            .where(
                (auto) => auto.Marca == widget.Marca) // Filtrar autos por marca
            .toList();

        setState(() {
          autos = filteredAutos;
          loading = false;
        });
      } else {
        throw Exception('Failed to load autos');
      }
    } catch (e) {
      print('Error fetching autos: $e');
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
              itemCount: autos.length,
              itemBuilder: (context, index) {
                final auto = autos[index];
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
                        final auto = autos[index];
                        return AlertDialog(
                          title: Text('Detalles del Auto'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Id: ${auto.id}'),
                              Text('Nombre: ${auto.Nombre}'),
                              Text('Estado: ${auto.Estado}'),
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
                          'Autos.png',
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.cover,
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
                              '${auto.Nombre}',
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
