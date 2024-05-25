import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_core/firebase_core.dart';

class Usuario{
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String contrasena;
  final String genero;
 


  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.contrasena,
    required this.genero,
   
  });

  factory Usuario.fromMap(DocumentSnapshot doc, Map<String, dynamic> dato){
    return Usuario(
      id: doc.id,
      nombre: dato['nombre'] ?? '',
      apellido: dato['apellido'] ?? '',
      correo: dato['correo'] ?? '',
      contrasena: dato['contrasena'] ?? '',
      genero: dato['genero'] ?? '',
      
    );
  }
}