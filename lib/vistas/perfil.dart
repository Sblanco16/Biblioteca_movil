import 'package:flutter/material.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rubricatres/vistas/usuario.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  bool generoMasculino = false;
  bool generoFemenino = false;

  final Servicios servicios = Servicios();

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? id = pref.getString('id');
    String? correo = pref.getString('email');
    String? nombre = pref.getString('name');
    String? apellido = pref.getString('last_name');
    String? genero = pref.getString('genre');

    if (id != null &&
        correo != null &&
        nombre != null &&
        apellido != null &&
        genero != null) {
      setState(() {
        nombreController.text = nombre;
        apellidoController.text = apellido;
        correoController.text = correo;
        idController.text = id;
        if (genero == 'Masculino') {
          generoMasculino = true;
        } else if (genero == 'Femenino') {
          generoFemenino = true;
        }
      });
    }
  }

  void actualizarUsuario() async {
    String nombre = nombreController.text.trim();
    String apellido = apellidoController.text.trim();
    String correo = correoController.text.trim();
    String genero = generoMasculino ? 'Masculino' : 'Femenino';

    if (nombre.isNotEmpty && apellido.isNotEmpty && correo.isNotEmpty) {
      Map<String, dynamic> datosActualizados = {
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'genero': genero,
      };

      await servicios.editarUsuario(idController.text, datosActualizados);
      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.clear();
      await pref.setString('id', idController.text);
      await pref.setString('name', nombre);
      await pref.setString('last_name', apellido);
      await pref.setString('email', correo);
      await pref.setString('genre', genero);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos actualizados con exito')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Usuario(nombre: nombre, id: idController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese todos los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
