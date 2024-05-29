import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rubricatres/vistas/AdBook.dart';
import 'package:rubricatres/vistas/detalles.dart';
import 'firebase_options.dart';
import 'package:rubricatres/vistas/registro_usu.dart';
import 'package:rubricatres/vistas/index.dart';
import 'package:rubricatres/vistas/login.dart';
import 'package:rubricatres/vistas/usuario.dart';
import 'package:rubricatres/vistas/perfil.dart';
import 'package:rubricatres/vistas/catalogo.dart';
import 'package:rubricatres/vistas/reservas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca :)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Index(),
        '/login': (context) => const Login(),
        '/registro': (context) => const RegistroUsu(),
        '/usuario': (context) => Usuario(
              nombre: '',
              id: " ",
            ),
        '/Perfil': (context) => Perfil(),
        '/AggLibros': (context) => AddBook(),
        '/Catalogo': (context) => CatalogoLibros(),
        '/reservas': (context) => LibrosReserv(userId: ''),
        '/Detalles':(context)=> DetallesLibro(libroId: ''),
      },
    );
  }
}