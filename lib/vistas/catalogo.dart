import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa FirebaseAuth
import 'package:rubricatres/metodos_firebase/metodos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogoLibros extends StatelessWidget {
  final Servicios _servicios = Servicios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Libros'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _servicios.obtenerLibros(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los libros'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay libros disponibles'));
          }

          final libros = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Número de columnas en el grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75, // Proporción de aspecto para las tarjetas
            ),
            padding: EdgeInsets.all(10),
            itemCount: libros.length,
            itemBuilder: (context, index) {
              final libro = libros[index];
              final nombre = libro['nombre libro'];
              final autor = libro['autor'];
              final descripcion = libro['descripcion'];
              final genero = libro['genero'];

              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Autor: $autor'),
                      Text('Género: $genero'),
                      SizedBox(height: 10),
                      Text(
                        descripcion,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          // Obtiene el usuario actualmente autenticado
                          User? usuario = FirebaseAuth.instance.currentUser;
                          if (usuario != null) {
                            // Utiliza el ID del usuario para guardar la reserva del libro en Firestore
                            await _servicios.reservarLibro(
                                libro.id, usuario.uid);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Libro reservado correctamente')),
                            );
                          } else {
                            // Maneja el caso en que no haya usuario autenticado
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Debes iniciar sesión para reservar el libro')),
                            );
                          }
                        },
                        child: Text('Reservar'),
                      ),
                     SizedBox(height:10),
                        ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetallesLibro(libro: libro),
                          //   ),
                          // );
                        },
                        child: Text('Detalles'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
