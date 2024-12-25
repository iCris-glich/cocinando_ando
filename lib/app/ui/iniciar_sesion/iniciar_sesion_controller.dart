import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Future<void> iniciarSesion(String email, String contrasena) async {
  final auth = FirebaseAuth.instance;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: contrasena,
    );

    Logger().i('Se inicio sesion con exito $userCredential');
  } catch (e) {
    Logger().e('Error al iniciar sesion $e');
  }
}
