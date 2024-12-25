import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Menuhorizontal extends StatelessWidget {
  const Menuhorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.cookie),
            onPressed: () => context.go('/agregar'),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pop(context); // Cierra el menú
            },
          ),
        ],
      ),
    );
  }
}
