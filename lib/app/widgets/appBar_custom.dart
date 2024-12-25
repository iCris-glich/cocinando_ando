import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppbarCustom extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Widget? button; // Botón personalizable

  const AppbarCustom({
    super.key,
    required this.title,
    this.height = 180.0,
    this.button, // Botón opcional
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<AppbarCustom> createState() => _AppbarCustomState();
}

class _AppbarCustomState extends State<AppbarCustom> {
  final TextEditingController _searchController = TextEditingController();
  String? nombreUsuario;

  @override
  void initState() {
    super.initState();
    obtenerDatosUsuario();
  }

  // Función para obtener los datos del usuario de Firestore
  Future<void> obtenerDatosUsuario() async {
    User? usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid) // Usamos UID para buscar el documento
          .get();

      if (snapshot.exists) {
        setState(() {
          nombreUsuario =
              snapshot['usuario']; // Asume que el campo se llama 'usuario'
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      elevation: 5,
      leading: widget.button, // Botón personalizable en la parte izquierda
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchBar(context),
        ),
      ],
    );
  }

  void _showSearchBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            labelText: '¿Qué buscas?',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
