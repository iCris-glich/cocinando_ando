import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger();

Future<void> crearUsuario(
    String email, String contrasena, String usuario) async {
  try {
    // Crear usuario en Firebase Authentication
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: contrasena,
    );
    _logger.i('Usuario creado: ${userCredential.user?.email}');

    // Guardar datos en Firestore
    await _guardarDatosEnFirestore(
        userCredential.user?.uid ?? '', usuario, email);
  } on FirebaseAuthException catch (authError) {
    _logger.e('Error de autenticación: ${authError.message}');
  } catch (e) {
    _logger.e('Error inesperado: $e');
  }
}

Future<void> _guardarDatosEnFirestore(
    String uid, String usuario, String email) async {
  try {
    // Verificar si el usuario ya existe en Firestore usando el uid
    final querySnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid) // Usamos el uid para obtener el documento del usuario
        .get();

    if (querySnapshot.exists) {
      _logger.w('El usuario con UID $uid ya existe en Firestore.');
      return;
    }

    // Guardar los datos del usuario en Firestore
    await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
      'fotoDePerfil':
          'https://img.freepik.com/foto-gratis/baya-fresa-levitando-sobre-fondo-blanco_485709-57.jpg',
      'usuario': usuario,
      'email': email,
      'creadoEl': FieldValue.serverTimestamp(),
    });
    _logger.i('Datos guardados en Firestore para el usuario $usuario');
  } catch (e) {
    _logger.e('Error al guardar los datos en Firestore: $e');
  }
}

Future<Map<String, dynamic>?> obtenerDatosUsuario() async {
  User? usuario = FirebaseAuth.instance.currentUser;

  if (usuario != null) {
    try {
      // Obtener los datos del usuario de Firestore usando el UID
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid) // Usamos el UID de Firebase Authentication
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      _logger.e('Error al obtener los datos del usuario: $e');
    }
  }
  return null;
}
