import 'package:flutter/material.dart';
import 'Category.dart';
import 'Brand.dart';
import 'Autos.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key, required this.title});

  final String title;

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
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
      body: Center(
        child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(title: 'Categorias'),
                ),
              );
            },
            child: Container(
              height: 150,
              color: Colors.yellow.shade800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Taller.jpeg',
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categorias',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BrandPage(title: 'Marcas'),
                ),
              );
            },
            child: Container(
              height: 150,
              color: Colors.yellow.shade800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Marcas.png',
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Marcas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AutosPage(title: 'Autos'),
                ),
              );
            },
            child: Container(
              height: 150,
              color: Colors.yellow.shade800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Marcas.png',
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Autos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
