import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Servicios {
  final FirebaseFirestore fs = FirebaseFirestore.instance;


//REGISTRO DE USUARIO
  Future<void> registroUsuario(String nombre, String apellido, String correo, String contrasena, String genero) async {
    try {
      DocumentReference docRef = await fs.collection("usuario").add({
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "contrasena": contrasena,
        "genero": genero,
       
      });
      //String proID = docRef.id;
      //print("id $proID");
    } catch (e) {
      print("error $e");
    }
  }

//EDITAR PERFIL DE USUARIO

Future<void> editarUsuario(String id, Map<String, dynamic> dato) async {

  try{
    await fs.collection("usuario").doc(id).update(dato);
  } catch (e){
    print("error $e");
  }
}

//login usuario
Future<DocumentSnapshot?> loginUsuario(String correo, String contrasena) async {
    try {
      QuerySnapshot snapshot = await fs.collection("usuario")
        .where('correo', isEqualTo: correo)
        .where('contrasena', isEqualTo: contrasena)
        .get();
      
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }

//lista de usuarios
Future<Map<String, dynamic>?> obtenerDatosUsuario(String userId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuario')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      print('El usuario no existe');
      return null;
    }
  } catch (e) {
    print('Error al obtener datos del usuario: $e');
    return null;
  }
}



}

