import 'package:flutter/material.dart';
import 'Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gara',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent.shade700),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'G-T'),
    );
  }
}



// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Cars> fetchCars() async {
//   final response = await http
//       .get(Uri.parse('http://127.0.0.1:8000/api/Cars/5'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Cars.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Cars');
//   }
// }

// class Cars {
//   final int id;
//   final String name;
//   final String status;
//   final String img;
//   final int brand_id;

//   const Cars({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.img,
//     required this.brand_id,
//   });

//   factory Cars.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'Id': int id,
//         'Name': String name,
//         'Status': String status,
//         'Img': String img,
//         'Brand': int brand_id,
//       } =>
//         Cars(
//           id: id,
//           name: name,
//           status: status,
//           img: img,
//           brand_id: brand_id,
//         ),
//       _ => throw const FormatException('Failed to load Car.'),
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
//   late Future<Cars> futureCars;

//   @override
//   void initState() {
//     super.initState();
//     futureCars= fetchCars();
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
//           child: FutureBuilder<Cars>(
//             future: futureCars,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(snapshot.data!.id.toString()),
//                     Text(snapshot.data!.name),
//                     Text(snapshot.data!.status),
//                     Text(snapshot.data!.img),
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