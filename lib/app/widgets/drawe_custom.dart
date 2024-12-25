import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocinando_ando/app/ui/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DraweCustom extends StatefulWidget {
  const DraweCustom({super.key});

  @override
  State<DraweCustom> createState() => _DraweCustomState();
}

class _DraweCustomState extends State<DraweCustom> {
  Stream<Map<String, String?>> obtenerDatosUsuarioStream() {
    User? usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      return FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return {
            'usuario': snapshot['usuario'] as String?,
            'fotoDePerfil': snapshot['fotoDePerfil'] as String?,
          };
        } else {
          return {'usuario': null, 'fotoDePerfil': null};
        }
      });
    } else {
      return Stream.value({'usuario': null, 'fotoDePerfil': null});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Column(
              children: [
                StreamBuilder<Map<String, String?>>(
                  stream: obtenerDatosUsuarioStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBxjJjwZScyyGZGB3D69jlzQHsdwACBjt4wg&s',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Cargando...',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      );
                    }

                    if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return const Text('Error al cargar datos');
                    }

                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final usuario = data['usuario'];
                      final fotoDePerfil = data['fotoDePerfil'];

                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: fotoDePerfil != null
                                ? NetworkImage(fotoDePerfil)
                                : NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBxjJjwZScyyGZGB3D69jlzQHsdwACBjt4wg&s',
                                  ) as ImageProvider, // Imagen predeterminada
                          ),
                          SizedBox(height: 10),
                          Text(
                            usuario ?? 'Usuario no disponible',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      );
                    } else {
                      return const Text('No hay datos disponibles');
                    }
                  },
                ),
                Spacer(),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => context.go('/'),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar sesión'),
            onTap: () {
              context.go('/registro');
              cerrarSesion();
            },
          ),
        ],
      ),
    );
  }
}
