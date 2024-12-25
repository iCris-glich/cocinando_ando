import 'package:flutter/material.dart';

class RecipeHeader extends StatelessWidget {
  final String nombreReceta;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const RecipeHeader({
    required this.nombreReceta,
    required this.onSave,
    required this.onShare,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          nombreReceta,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        InkWell(
          onTap: onShare,
          child: Icon(Icons.share, size: 30),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: onSave,
          child: Icon(Icons.save, size: 30),
        ),
      ],
    );
  }
}
