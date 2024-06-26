import 'package:flutter/material.dart';
import 'package:rubricatres/vistas/reservas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario extends StatefulWidget {
  final String nombre;
  final String id;
  Usuario({required this.nombre, required this.id});

  @override
  State<Usuario> createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de Usuario'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  'Te damos la bienvenida, ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.nombre,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('Mi Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/Perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.library_add, color: Colors.blue),
              title: Text('Agregar libro'),
              onTap: () {
                Navigator.pushNamed(context, '/AggLibros');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue),
              title: Text('Mis Reservas'),
              onTap: () {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LibrosReserv(userId: widget.id),
          ),
        );
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books, color: Colors.blue),
              title: Text('Catálogo de Libros'),
              onTap: () {
                Navigator.pushNamed(context, '/Catalogo');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.blue),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
              },
            ),  
          ],
        ),
      ),
    );
  }
}
