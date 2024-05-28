import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Servicios {
  final FirebaseFirestore fs = FirebaseFirestore.instance;

//REGISTRO DE USUARIO
  Future<void> registroUsuario(String nombre, String apellido, String correo,
      String contrasena, String genero) async {
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
    try {
      await fs.collection("usuario").doc(id).update(dato);
    } catch (e) {
      print("error $e");
    }
  }

//login usuario
  Future<DocumentSnapshot?> loginUsuario(
      String correo, String contrasena) async {
    try {
      QuerySnapshot snapshot = await fs
          .collection("usuario")
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('usuario')
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

//Agg libros
  Future<void> Addlibro(
      String name, String author, String bookgendre, String description) async {
    try {
      DocumentReference docRef = await fs.collection("Libros").add({
        "descripcion": description,
        "autor": author,
        "nombre libro": name,
        "genero": bookgendre,
      });
      //String proID = docRef.id;
      //print("id $proID");
    } catch (e) {
      print("error $e");
    }
  }

  // Obtener lista de libros
  Stream<QuerySnapshot> obtenerLibros() {
    return fs.collection("Libros").snapshots();
  }

  // Verificar si un libro está reservado por un usuario
  Future<bool> estaReservado(String libroId, String userId) async {
    try {
      QuerySnapshot snapshot = await fs
          .collection("Reservas")
          .where('libroId', isEqualTo: libroId)
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error al verificar la reserva: $e');
      return false;
    }
  }

  // Obtener la lista de libros reservados por un usuario

  // Reservar libro
  Future<void> reservarLibro(String libroId, String userId) async {
    try {
      await fs.collection("Reservas").add({
        'libroId': libroId,
        'userId': userId,
      });
      print('Libro reservado con éxito');
    } catch (e) {
      print('Error al reservar libro: $e');
    }
  }
}
