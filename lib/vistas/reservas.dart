import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';

class LibrosReserv extends StatefulWidget {
  final String userId;

  LibrosReserv({required this.userId});

  @override
  State<LibrosReserv> createState() => _LibrosReservState();
}

class _LibrosReservState extends State<LibrosReserv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros Reservados'),
      ),
      body: StreamBuilder(
        //coleccion de libros
        stream: FirebaseFirestore.instance
            .collection('Reservas')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tiene libros reservados'));
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              String libroId = document['libroId'];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Libros')
                    .doc(libroId)
                    .get(),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> libroSnapshot) {
                  if (libroSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (libroSnapshot.hasError) {
                    return ListTile(
                      title: Text('Error al cargar el libro'),
                      subtitle: Text('ID: $libroId'),
                    );
                  }
                  if (!libroSnapshot.hasData || !libroSnapshot.data!.exists) {
                    return ListTile(
                      title: Text('Libro no encontrado'),
                      subtitle: Text('ID: $libroId'),
                    );
                  }

                  Map<String, dynamic>? libroData =
                      libroSnapshot.data!.data() as Map<String, dynamic>?;

                  String titulo =
                      libroData?['nombre libro'] ?? 'Título no disponible';
                  String autor = libroData?['autor'] ?? 'Autor no disponible';
                  // String genero =
                  //     libroData?['genero'] ?? 'Genero no disponible';

                  // Se puede traer todo lo del libro

                  return ListTile(
                    title: Text(titulo),
                    subtitle: Text('Autor: $autor'),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
