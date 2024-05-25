import 'package:flutter/material.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';
import 'package:rubricatres/pantallas/usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final Servicios servicios = Servicios();

  void loginUsuario() async {
    String correo = correoController.text.trim();
    String contrasena = contrasenaController.text.trim();

    if (correo.isNotEmpty && contrasena.isNotEmpty) {
      var userDoc = await servicios.loginUsuario(correo, contrasena);

      if (userDoc != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bienvenido')),
        );
        String nombreUsuario = userDoc['nombre']; 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Usuario(nombre: nombreUsuario),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al iniciar sesión')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.library_books,
                  size: 100.0,
                  color: Colors.blue,
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: correoController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contrasenaController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loginUsuario,
                  child: const Text('Entrar', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  child: const Text('¿No tienes una cuenta? Regístrate aquí', 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

