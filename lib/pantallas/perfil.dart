import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';

class Perfil extends StatefulWidget {
  final String userId;

  const Perfil({Key? key, required this.userId}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  bool generoMasculino = false;
  bool generoFemenino = false;

  final Servicios servicios = Servicios();

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuario')
        .doc(widget.userId)
        .get();

    if (userDoc.exists) {
      setState(() {
        nombreController.text = userDoc['nombre'];
        apellidoController.text = userDoc['apellido'];
        correoController.text = userDoc['correo'];
        contrasenaController.text = userDoc['contrasena'];
        if (userDoc['genero'] == 'Masculino') {
          generoMasculino = true;
        } else if (userDoc['genero'] == 'Femenino') {
          generoFemenino = true;
        }
      });
    }
  }

  void actualizarUsuario() async {
    String nombre = nombreController.text.trim();
    String apellido = apellidoController.text.trim();
    String correo = correoController.text.trim();
    String contrasena = contrasenaController.text.trim();
    String genero = generoMasculino ? 'Masculino' : 'Femenino';

    if (nombre.isNotEmpty && apellido.isNotEmpty && correo.isNotEmpty && contrasena.isNotEmpty) {
      Map<String, dynamic> datosActualizados = {
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'contrasena': contrasena,
        'genero': genero,
      };

      await servicios.editarUsuario(widget.userId, datosActualizados);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado ')),
      );
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
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person,
                  size: 100.0,
                  color: Colors.blue,
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: apellidoController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: correoController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: contrasenaController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 16.0),
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
                      const Text('Masculino'),
                      Checkbox(
                        value: generoFemenino,
                        onChanged: (bool? value) {
                          setState(() {
                            generoFemenino = value ?? false;
                            if (generoFemenino) generoMasculino = false;
                          });
                        },
                      ),
                      const Text('Femenino'),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: actualizarUsuario,
                    child: const Text(
                      'Actualizar',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
