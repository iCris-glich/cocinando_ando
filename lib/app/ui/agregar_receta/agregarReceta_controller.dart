import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Future<void> agregarReceta(
  String nombreReceta,
  String pasosParaRealizarReceta,
  String ingredientes,
  String tiempoPreparacion,
  String tipoDeReceta,
) async {
  try {
    // Obtén el uid del usuario autenticado
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      Logger().e(
          'No se pudo obtener el UID del usuario. El usuario no está autenticado.');
      return;
    }

    // Agrega la receta a Firestore con el userId
    await FirebaseFirestore.instance.collection('recetas').add({
      'nombreReceta': nombreReceta,
      'pasosParaRealizarReceta': pasosParaRealizarReceta,
      'ingredientes': ingredientes,
      'tiempoPreparacion': tiempoPreparacion,
      'tipoReceta': tipoDeReceta,
      'creadoEl': FieldValue.serverTimestamp(),
      'userId': uid, // Campo que guarda el ID del usuario
    });

    Logger().i('Receta $nombreReceta guardada con éxito');
  } on FirebaseException catch (e) {
    Logger().e('Error en Firestore: ${e.message}');
  } catch (e) {
    Logger().e('Error inesperado: $e');
  }
}
