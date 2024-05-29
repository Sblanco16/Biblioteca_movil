import 'package:flutter/material.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetallesLibro extends StatelessWidget {
  final String libroId;

  DetallesLibro({required this.libroId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Libro'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Libros').doc(libroId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Libro no encontrado'));
          }

          Map<String, dynamic>? libroData = snapshot.data!.data() as Map<String, dynamic>?;

          String titulo = libroData?['nombre libro'] ?? 'Título no disponible';
          String autor = libroData?['autor'] ?? 'Autor no disponible';
          String descripcion = libroData?['descripcion'] ?? 'Descripción no disponible';
          String genero = libroData?['genero'] ?? 'Género no disponible';

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Autor: $autor',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Text(
                  'Género: $genero',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Text(
                  descripcion,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

