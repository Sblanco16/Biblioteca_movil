// import 'package:cloud_firestore/cloud_firestore.dart'; 
// import 'package:firebase_core/firebase_core.dart';

// class Libro{
//   final String id;
//   final String nombre_libro;
//   final String autor;
//   final String descripcion;
//   final String genero;
 
//   Libro({
//     required this.id,
//     required this.nombre_libro,
//     required this.autor,
//     required this.descripcion,
//     required this.genero,   
//   });

//   factory Libro.fromMap(DocumentSnapshot doc, Map<String, dynamic> dato){
//     return Libro(
//       id: doc.id,
//       nombre_libro: dato['nombre libro'] ?? '',
//       autor: dato['autor'] ?? '',
//       descripcion: dato['descripcion'] ?? '', 
//       genero: dato['genero'] ?? '', 
//     );
//   }
// }