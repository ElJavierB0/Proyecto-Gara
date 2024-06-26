import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';
import 'Autos.dart';
import 'Brand.dart';
import 'Category.dart';
import 'Car.dart';
import 'Historial.dart';
import 'Job.dart';
import 'Login.dart';
import 'Modificaciones.dart';
import 'Persona.dart';
import 'Record.dart';
import 'Remplacement.dart';
import 'Reparaciones.dart';
import 'Service.dart';
import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Inicio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  String lastSearch = '';
  List<dynamic> searchResults = [];
  List<Widget> carouselItems = [];
  String? _userName;
  int? _selectedIndex;

  static const List<Widget> _widgetOptions = <Widget>[
    Icon(Icons.people),
    Icon(Icons.post_add),
    Icon(Icons.home),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> search(String term) async {
    try {
      final autos = await fetchAutos(term);
      final brands = await fetchBrands(term);
      final categories = await fetchCategories(term);
      final replacements = await fetchReplacements(term);
      final servicios = await fetchServicios(term);

      setState(() {
        searchResults = [
          ...autos.where((auto) =>
              auto.id.toString() == term ||
              auto.Nombre.contains(term) ||
              auto.Estado.contains(term) ||
              auto.Marca.toString() == term),
          ...brands.where((brand) =>
              brand.id.toString() == term ||
              brand.Nombre.contains(term) ||
              brand.Categoria.toString() == term),
          ...categories.where((category) =>
              category.id.toString() == term || category.Tipo.contains(term)),
          ...replacements.where((replacement) =>
              replacement.id.toString() == term ||
              replacement.name.contains(term) ||
              replacement.type.contains(term)),
          ...servicios.where((servicio) =>
              servicio.id.toString() == term ||
              servicio.Nombre.contains(term) ||
              servicio.Tipo.contains(term)),
        ];
        lastSearch = term;
        if (searchResults.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('No se encontraron resultados'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
      });
    } catch (e) {
      print('Error during search: $e');
    }
  }

  Future<void> _logout(BuildContext context) async {
    // Eliminar los datos de sesión de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('profile');
    // Redirigir a LoginPage después de cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(title: 'Gara'),
      ),
    );
  }

  Future<List<Autos>> fetchAutos(String term) async {
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

  Future<List<Brand>> fetchBrands(String term) async {
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

  Future<List<Category>> fetchCategories(String term) async {
    final response = await http
        .get(Uri.parse('https://romo.terrabyteco.com/api/Categories'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<Category> categories =
          jsonResponse.map((data) => Category.fromJson(data)).toList();
      return categories;
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  Future<List<Remplacement>> fetchReplacements(String term) async {
    final response = await http
        .get(Uri.parse('https://romo.terrabyteco.com/api/Remplacements'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<Remplacement> replacements =
          jsonResponse.map((data) => Remplacement.fromJson(data)).toList();
      return replacements;
    } else {
      throw Exception('Failed to load Replacements');
    }
  }

  Future<List<Servicios>> fetchServicios(String term) async {
    final response =
        await http.get(Uri.parse('https://romo.terrabyteco.com/api/Services'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<Servicios> servicios =
          jsonResponse.map((data) => Servicios.fromJson(data)).toList();
      return servicios;
    } else {
      throw Exception('Failed to load Servicios');
    }
  }

  @override
  void initState() {
    super.initState();
    updateCarouselItems();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userProfile = prefs.getString('profile');
    if (userProfile != null) {
      Map<String, dynamic> profileData = jsonDecode(userProfile);
      setState(() {
        _userName = profileData['name'];
      });
    } else {
      setState(() {
        _userName =
            ''; // o algún valor predeterminado si no hay perfil almacenado
      });
    }
  }

  Future<List<Servicios>> getRandomServices() async {
    try {
      final response = await http
          .get(Uri.parse('https://romo.terrabyteco.com/api/Services'));

      if (response.statusCode == 200) {
        Iterable jsonResponse = jsonDecode(response.body);
        List<Servicios> allServices =
            jsonResponse.map((data) => Servicios.fromJson(data)).toList();

        allServices.shuffle();
        List<Servicios> randomServices = allServices.take(3).toList();

        return randomServices;
      } else {
        throw Exception('Failed to load Servicios');
      }
    } catch (e) {
      print('Error during getRandomServices: $e');
      return [];
    }
  }

  Future<void> updateCarouselItems() async {
    List<Servicios> randomServices = await getRandomServices();

    carouselItems = randomServices.map((servicio) {
      return Card(
        color: Colors.yellow.shade800,
        child: Column(
          children: [
            Text('Servicio: ${servicio.Nombre}'),
            Text('Tipo: ${servicio.Tipo}'),
          ],
        ),
      );
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bienvenido $_userName', // Aquí se muestra el nombre del usuario
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.garage),
              title: Text('Trabajos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobsPage(title: 'Trabajos'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Carros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarsPage(title: 'Carros'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Refacciones'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RemplacementPage(title: 'Refacciones'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text('Cuenta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersPage(title: 'Cuenta'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                _logout(
                    context); // Llama a la función _logout y pasa el contexto
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: 600.0, // Definir el ancho deseado
        height: 800.0, // Definir la altura deseada
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade800,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info,
                                color:
                                    Colors.blueGrey.shade900.withOpacity(0.4)),
                            SizedBox(width: 8),
                            Text(
                              'Ten en cuenta que busca por Nombre normalmente...',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade900
                                      .withOpacity(0.4)),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                style:
                                    TextStyle(color: Colors.blueGrey.shade900),
                                decoration: InputDecoration(
                                  hintText: 'Buscar...',
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey.shade900),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.search,
                                      color: Colors.blueGrey.shade900),
                                  onPressed: () {
                                    String searchTerm = searchController.text;
                                    search(searchTerm);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.cleaning_services_outlined,
                                      color: Colors.blueGrey.shade900),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {
                                      searchResults = [];
                                      lastSearch = '';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final result = searchResults[index];
                    return ListTile(
                      title: Text(getResultTitle(result)),
                      onTap: () {
                        _handleResultTap(context, result);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: CarouselSlider(
                  items: [
                    Image.network(
                        'https://images.pexels.com/photos/9661335/pexels-photo-9661335.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Image.network(
                        'https://images.unsplash.com/photo-1551522435-a13afa10f103?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2FyYWplfGVufDB8fDB8fHww',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Image.network(
                        'https://images.pexels.com/photos/8134647/pexels-photo-8134647.jpeg?auto=compress&cs=tinysrgb&w=600',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Image.network(
                        'https://images.unsplash.com/photo-1486006920555-c77dcf18193c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2FyYWplfGVufDB8fDB8fHww',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Image.network(
                        'https://images.pexels.com/photos/159293/car-engine-motor-clean-customized-159293.jpeg?auto=compress&cs=tinysrgb&w=600',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                    Image.network(
                        'https://images.pexels.com/photos/6364560/pexels-photo-6364560.jpeg?auto=compress&cs=tinysrgb&w=600',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover),
                  ],
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Añadir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: _selectedIndex ?? 0,
        selectedItemColor: Colors.yellow.shade800,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          // Aquí redirige a la vista correspondiente según el índice seleccionado
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonaPage(
                      title: 'Usuarios'), // Reemplaza con tu página de personas
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordsPage(
                      title: 'Registro'), // Reemplaza con tu página de añadir
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistorialPage(
                      title:
                          'Historial'), // Reemplaza con tu página de historial
                ),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  void _handleResultTap(BuildContext context, dynamic result) {
    if (result is Autos) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AutosPage(title: 'Autos'),
        ),
      );
    } else if (result is Brand) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrandPage(title: 'Marcas'),
        ),
      );
    } else if (result is Category) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPage(title: 'Categorias'),
        ),
      );
    } else if (result is Remplacement) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RemplacementPage(title: 'Refacciones'),
        ),
      );
    } else if (result is Servicios) {
      // Manejar los diferentes tipos de trabajo (servicios)
      switch (result.Tipo) {
        case 'servicio':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicesPage(title: 'Servicios'),
            ),
          );
          break;
        case 'modificacion':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ModificacionesPage(title: 'Modificaciones'),
            ),
          );
          break;
        case 'reparacion':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReparacionesPage(title: 'Reparaciones'),
            ),
          );
          break;
        default:
          // Manejar cualquier otro caso si es necesario
          break;
      }
    }
  }

  String getResultTitle(dynamic result) {
    if (result is Autos) {
      return 'Auto: ${result.Nombre}';
    } else if (result is Brand) {
      return 'Marca: ${result.Nombre}';
    } else if (result is Category) {
      return 'Categoría: ${result.Tipo}';
    } else if (result is Remplacement) {
      return 'Refacción: ${result.name}';
    } else if (result is Servicios) {
      // Identificar los tipos de trabajo (servicios)
      String servicioTipo = '';
      switch (result.Tipo) {
        case 'servicio':
          servicioTipo = 'Servicio';
          break;
        case 'modificacion':
          servicioTipo = 'Modificación';
          break;
        case 'reparacion':
          servicioTipo = 'Reparación';
          break;
      }
      return '${result.Tipo}: ${result.Nombre}';
    } else {
      return '';
    }
  }
}
