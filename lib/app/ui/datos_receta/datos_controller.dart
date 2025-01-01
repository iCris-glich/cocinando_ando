import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocinando_ando/app/ui/datos_receta/receper_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DatosController extends StatelessWidget {
  final String? recetaId;

  const DatosController({super.key, required this.recetaId});

  @override
  Widget build(BuildContext context) {
    final recetaRef =
        FirebaseFirestore.instance.collection('recetas').doc(recetaId);

    return FutureBuilder<DocumentSnapshot>(
      future: recetaRef.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('Error al cargar los datos: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Receta no encontrada.'));
        }

        var receta = snapshot.data!;
        String nombreReceta = receta['nombreReceta'] ?? 'Receta sin nombre';
        String pasosParaRealizarReceta =
            receta['pasosParaRealizarReceta'] ?? 'Pasos no disponibles.';
        String ingredientesReceta =
            receta['ingredientes'] ?? 'Ingredientes no disponibles.';
        String tiempoPreparacion =
            receta['tiempoPreparacion'] ?? 'Tiempo no especificado.';
        String tipoReceta = receta['tipoReceta'] ?? 'Tipo no especificado.';

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              color: const Color(0xffE8C598),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RecipeHeader(
                      nombreReceta: nombreReceta,
                      onSave: () {},
                      onShare: () {},
                      editing: () {
                        context.go('/editar/$recetaId');
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/4100/4100980.png',
                          height: 30,
                          width: 30,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tiempoPreparacion,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text(
                      'Ingredientes:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(ingredientesReceta,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text(
                      'Pasos para realizar la receta:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(pasosParaRealizarReceta,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text(
                      'Tipo de receta: $tipoReceta',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
