import 'package:flutter/material.dart';
import "package:rubricatres/metodos_firebase/metodos.dart";

class RegistroUsu extends StatefulWidget {
  const RegistroUsu({super.key});

  @override
  _RegistroUsuState createState() => _RegistroUsuState();
}

class _RegistroUsuState extends State<RegistroUsu> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final Servicios _servicios = Servicios();

  bool generoMasculino = false;
  bool generoFemenino = false;

  String get generoSeleccionado {
    if (generoMasculino) return 'Masculino';
    if (generoFemenino) return 'Femenino';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                  Icons.person_add,
                  size: 100,
                  color: Colors.blue,
                ),

              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                   border: OutlineInputBorder(),
                ),
              ),
              ),

              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: TextField(
                controller: apellidoController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icon(Icons.person), 
                  border: OutlineInputBorder(),
                ),
              ),
              ),

              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: TextField(
                controller: correoController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
               ),

              SizedBox(height: 16),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child:  TextField(
                controller: contrasenaController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
             ),
              SizedBox(height: 16),
              Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, 
    children: [
      Checkbox(
        value: generoMasculino,
        onChanged: (bool? value) {
          setState(() {
            generoMasculino = value ?? false;
            if (generoMasculino) generoFemenino = false;
          });
        },
      ),
      Text('Masculino'),
      Checkbox(
        value: generoFemenino,
        onChanged: (bool? value) {
          setState(() {
            generoFemenino = value ?? false;
            if (generoFemenino) generoMasculino = false;
          });
        },
      ),
      Text('Femenino'),
    ],
  ),
),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 250),
                child: ElevatedButton(
                onPressed: () async {
                  String nombre = nombreController.text.trim();
                  String apellido = apellidoController.text.trim();
                  String correo = correoController.text.trim();
                  String contrasena = contrasenaController.text.trim();
                  String genero = generoSeleccionado;

                  if (nombre.isNotEmpty &&
                      apellido.isNotEmpty &&
                      correo.isNotEmpty &&
                      contrasena.isNotEmpty &&
                      genero.isNotEmpty) {
                    try {
                      await _servicios.registroUsuario(
                        nombre,
                        apellido,
                        correo,
                        contrasena,
                        genero,
                      );
                     
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Usuario registrado :)')),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                     
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al registrar usuario :( ): $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, complete todos los campos')),
                    );
                  }
                },
                child: Text('Registrarse'
                 ,style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              ),

              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('¿Ya tienes una cuenta? Inicia sesión aquí', 
                style: TextStyle(color: Colors.black), ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}