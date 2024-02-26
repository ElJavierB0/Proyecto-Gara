// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'userId': int userId,
//         'id': int id,
//         'title': String title,
//       } =>
//         Album(
//           userId: userId,
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }
// }

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Obtener Datos',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Obtener Datos'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(snapshot.data!.title),
//                     Text(snapshot.data!.id.toString())
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Car> fetchCar() async {
//   final response = await http
//       .get(Uri.parse('http://127.0.0.1:8000/api/Services/5'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Car {
//   final String name;
//   final String status;
//   final String img;
//   final int brand_id;

//   const Car({
//     required this.name,
//     required this.status,
//     required this.img,
//     required this.brand_id,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'Name': String name,
//         'Status': String status,
//         'Img': String img,
//         'Brand': int brand_id,
//       } =>
//         Car(
//           name: name,
//           status: status,
//           img: img,
//           brand_id: brand_id,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }
// }

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<Car> futureCar;

//   @override
//   void initState() {
//     super.initState();
//     futureCar= fetchCar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Obtener Datos',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Obtener Datos'),
//         ),
//         body: Center(
//           child: FutureBuilder<Car>(
//             future: futureCar,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(snapshot.data!.name),
//                     Text(snapshot.data!.status)
//                     Text(snapshot.data!.img)
//                     Text(snapshot.data!.brand_id.toString())
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RemplacementPageState extends State<RemplacementPage> {
//   late Future<Remplacement> futureRemplacement;

//   @override
//   void initState() {
//     super.initState();
//     futureRemplacement = fetchRemplacement();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey.shade900,
//         title: Text(
//           widget.title,
//           style: TextStyle(color: Colors.yellow.shade800),
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder<Remplacement>(
//           future: futureRemplacement,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Card(
//                 margin: EdgeInsets.all(16),
//                 elevation: 5,
//                 child: Column(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                       child: Image.asset(
//                         'Taller.jpeg',
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             snapshot.data!.name,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             snapshot.data!.type,
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }

//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
