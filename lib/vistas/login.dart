import 'package:flutter/material.dart';
import 'package:rubricatres/metodos_firebase/metodos.dart';
import 'package:rubricatres/vistas/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override 
  void initState(){super.initState();Validarpref();}
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
        String apellidoUsuario = userDoc['apellido'];
        String correoUsuario = userDoc['correo'];
        String generoUsuario = userDoc['genero'];
        String idUsuario = userDoc.id;
        print(idUsuario);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('name', nombreUsuario);
        await pref.setString('last_name', apellidoUsuario);
        await pref.setString('email', correoUsuario);
        await pref.setString('genre', generoUsuario);
        await pref.setString('id', idUsuario);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Usuario(nombre: nombreUsuario, id: idUsuario),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error! usuario o contraseña incorrecta')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese los datos :D')),
      );
    }
  }

  Future <void> Validarpref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('id');
    String? nombre = pref.getString('name');
    
    if(id != null && nombre != null){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Usuario(nombre: nombre, id: id)
          ),
        );
    }else{
      print('ou nouu');
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], 
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.blue[700], 
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.library_books,
                  size: 100.0,
                  color: Colors.blue[700], 
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: correoController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contrasenaController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loginUsuario,
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700], 
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  child: Text(
                    '¿No tienes una cuenta? Regístrate aquí',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

