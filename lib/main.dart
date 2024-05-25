import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:rubricatres/pantallas/registro_usu.dart';
import 'package:rubricatres/pantallas/index.dart';
import 'package:rubricatres/pantallas/login.dart';
import 'package:rubricatres/pantallas/usuario.dart';
import 'package:rubricatres/pantallas/perfil.dart';


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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Index(),
        '/login': (context) => const Login(),
        '/registro': (context) => const RegistroUsu(),
        '/usuario': (context) => Usuario(nombre: '', ),
         '/perfil': (context) => Perfil(userId: ''), 


      
       
      },
    );
  }
}

