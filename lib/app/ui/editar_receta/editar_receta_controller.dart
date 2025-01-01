import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

Future<void> actualizarReceta(
    String recetaId, Map<String, dynamic> recetaActualizada) async {
  try {
    // Intentando actualizar la receta en Firestore
    await FirebaseFirestore.instance
        .collection('recetas')
        .doc(recetaId)
        .update(recetaActualizada);
    Logger().i('Receta $recetaId actualizada con éxito');
  } catch (e) {
    // Captura el error y muestra información detallada
    Logger().e('Error al actualizar la receta $recetaId: $e');
  }
}
