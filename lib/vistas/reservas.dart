import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rubricatres/vistas/detalles.dart';
import 'package:rubricatres/vistas/usuario.dart';

class LibrosReserv extends StatefulWidget {
  final String userId;

  LibrosReserv({required this.userId});

  @override
  State<LibrosReserv> createState() => _LibrosReservState();
}

class _LibrosReservState extends State<LibrosReserv> {
  void CancelReserva(String reservaId) async {
    try {
      await FirebaseFirestore.instance.collection('Reservas').doc(reservaId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva cancelada')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cancelar reserva: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros Reservados'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
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
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tiene nada reservado'));
          }
          return ListView(
            padding: EdgeInsets.all(10),
            children: snapshot.data!.docs.map((document) {
              String reservaId = document.id;
              String libroId = document['libroId'];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Libros')
                    .doc(libroId)
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> libroSnapshot) {
                  if (libroSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (libroSnapshot.hasError) {
                    return ListTile(
                      title: Text('Error al cargar libro :c'),
                      subtitle: Text('ID: $libroId'),
                    );
                  }
                  if (!libroSnapshot.hasData || !libroSnapshot.data!.exists) {
                    return ListTile(
                      title: Text('Libro no encontrado :c'),
                      subtitle: Text('ID: $libroId'),
                    );
                  }
                  Map<String, dynamic>? libroData = libroSnapshot.data!.data() as Map<String, dynamic>?;
                  String titulo = libroData?['nombre libro'] ?? 'Título no disponible';
                  String autor = libroData?['autor'] ?? 'Autor no disponible';

                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Autor: $autor',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetallesLibro(libroId: libroId),
                                    ),
                                  );
                                },
                                child: Text('Detalles'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  CancelReserva(reservaId);
                                },
                                child: Text('Cancelar Reserva'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
