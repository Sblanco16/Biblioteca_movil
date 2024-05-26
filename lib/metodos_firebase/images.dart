// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FutureBuilder(
//           future: _loadImage(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(snapshot.data),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
// }

// Future<String> _loadImage() async {
//   final ref = FirebaseStorage.instance.ref().child('/Images/fondoindex.jpg');
//   return await ref.getDownloadURL();
// }
