import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

// Función para cerrar sesión
Future<void> cerrarSesion() async {
  try {
    await FirebaseAuth.instance.signOut();
    Logger().w('Se ha cerrado sesión');
  } catch (e) {
    Logger().e('Error al cerrar sesión: $e');
  }
}

// Función para eliminar una receta
Future<void> eliminarReceta(String recetaId) async {
  try {
    // Referencia al documento de la receta que deseas eliminar
    await FirebaseFirestore.instance
        .collection('recetas')
        .doc(recetaId)
        .delete();
    Logger().i('Receta eliminada con éxito');
  } catch (e) {
    Logger().e('Error al eliminar la receta: $e');
  }
}

Future<void> actualizarReceta(String recetaId, String nombreReceta,
    String descripcion, String ingredientes, String tiempoPreparacion) async {
  try {
    await FirebaseFirestore.instance
        .collection('recetas')
        .doc(recetaId)
        .update({
      'nombreReceta': nombreReceta,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'tiempoPreparacion': tiempoPreparacion,
      'actualizadoEl': FieldValue.serverTimestamp(),
    });

    Logger().i('Receta $nombreReceta actualizada con éxito');
  } catch (e) {
    Logger().e('Error al actualizar la receta: $e');
  }
}

class MostrarRecetas extends StatefulWidget {
  const MostrarRecetas({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateMostrarRecetas();
  }
}

class StateMostrarRecetas extends State<MostrarRecetas> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return const Center(
          child: Text('Por favor, inicie sesión para ver las recetas.'));
    }

    final Stream<QuerySnapshot> recetasStream = FirebaseFirestore.instance
        .collection('recetas')
        .where('userId', isEqualTo: uid)
        .snapshots();

    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: recetasStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No hay recetas disponibles.'));
            }

            final recetas = snapshot.data!.docs;

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: recetas.length,
              itemBuilder: (context, index) {
                final receta = recetas[index];
                final recetaId = receta.id;
                final data = receta.data() as Map<String, dynamic>;

                return InkWell(
                  onTap: () {
                    context.push('/datos/$recetaId');
                  },
                  child: Draggable<Map<String, String>>(
                    data: {
                      'id': recetaId,
                      'nombre': data['nombreReceta'] ?? ''
                    },
                    feedback: Opacity(
                      opacity: 0.7,
                      child: Card(
                        color: Colors.red.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            data['nombreReceta'] ?? 'Sin título',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Card(
                        color: const Color(0xffF4A460),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['nombreReceta'] ?? 'Sin título',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Tiempo: ${data['tiempoPreparacion'] ?? '0 min'}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: Card(
                      color: const Color(0xffF4A460),
                      elevation: 4,
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['nombreReceta'] ?? 'Sin título',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Tiempo: ${data['tiempoPreparacion'] ?? '0 min'}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: DragTarget<Map<String, String>>(
            onAccept: (data) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:
                          const Text('¿Seguro que quieres eliminar la receta?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            eliminarReceta(data['id']!);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${data['nombre']} eliminada con éxito'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    );
                  });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Column(
                children: [
                  Icon(
                    Icons.delete,
                    size: 50,
                    color: accepted.isNotEmpty ? Colors.red : Colors.grey,
                  ),
                  Text(
                    'Eliminar',
                    style: TextStyle(
                      color: accepted.isNotEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
