import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LibrosReserv extends StatelessWidget {
  final String userId;

  LibrosReserv({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros Reservados'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('reservas')
            .where('userId', isEqualTo: userId)
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
              Map<String, dynamic> reserva = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(reserva['titulo']),
                subtitle: Text('Autor: ${reserva['autor']}'),
                // Aquí puedes agregar más detalles de la reserva, como la fecha, etc.
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
