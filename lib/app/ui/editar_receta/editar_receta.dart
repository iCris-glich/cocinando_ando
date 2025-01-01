import 'package:cocinando_ando/app/widgets/appBar_custom.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/textField_custom.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class EditarReceta extends StatefulWidget {
  final String? recetaId;

  const EditarReceta({super.key, required this.recetaId});

  @override
  State<StatefulWidget> createState() => StateEditar();
}

class StateEditar extends State<EditarReceta> {
  final TextEditingController _nombreReceta = TextEditingController();
  final TextEditingController _pasosParaRealizarReceta =
      TextEditingController();
  final TextEditingController _ingredientesReceta = TextEditingController();
  final TextEditingController _tiempoDePreparacionReceta =
      TextEditingController();
  String _errorMessage = '';
  String? _tipoSeleccionado;

  @override
  void initState() {
    super.initState();
    _cargarReceta();
  }

  Future<void> _cargarReceta() async {
    if (widget.recetaId == null) {
      print("Error: recetaId no proporcionado.");
      return;
    }

    try {
      DocumentSnapshot recetaSnapshot = await FirebaseFirestore.instance
          .collection('recetas')
          .doc(widget.recetaId)
          .get();

      if (recetaSnapshot.exists) {
        var recetaData = recetaSnapshot.data() as Map<String, dynamic>;

        _nombreReceta.text = recetaData['nombreReceta'] ?? '';
        _pasosParaRealizarReceta.text =
            recetaData['pasosParaRealizarReceta'] ?? '';
        _ingredientesReceta.text = recetaData['ingredientes'] ?? '';
        _tiempoDePreparacionReceta.text = recetaData['tiempoPreparacion'] ?? '';
        _tipoSeleccionado = recetaData['tipoReceta'] ?? '';
      } else {
        setState(() {
          _errorMessage = 'Receta no encontrada';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar la receta: $e';
      });
    }
  }

  Future<void> _salvarCambios() async {
    if (_nombreReceta.text.isEmpty ||
        _pasosParaRealizarReceta.text.isEmpty ||
        _ingredientesReceta.text.isEmpty ||
        _tiempoDePreparacionReceta.text.isEmpty ||
        _tipoSeleccionado == null) {
      setState(() {
        _errorMessage = 'Por favor completa todos los campos';
      });
      return;
    }

    if (widget.recetaId == null) {
      setState(() {
        _errorMessage = 'Error: recetaId no proporcionado.';
      });
      return;
    }

    final recetaActualizada = {
      'nombreReceta': _nombreReceta.text,
      'pasosParaRealizarReceta': _pasosParaRealizarReceta.text,
      'tiempoPreparacion': _tiempoDePreparacionReceta.text,
      'ingredientes': _ingredientesReceta.text,
      'tipoReceta': _tipoSeleccionado,
    };

    try {
      await FirebaseFirestore.instance
          .collection('recetas')
          .doc(widget.recetaId)
          .update(recetaActualizada);

      setState(() {
        _errorMessage = '';
      });

      print('Receta actualizada correctamente.');
      context.go('/');
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al actualizar la receta: $e';
      });
    }
  }

  Future<void> _seleccionarTipo() async {
    final List<String> tipos = [
      'Entrada',
      'Plato Principal',
      'Postre',
      'Bebida'
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona el tipo de receta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: tipos.map((tipo) {
              return ListTile(
                title: Text(tipo),
                leading: Radio<String>(
                  value: tipo,
                  groupValue: _tipoSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      _tipoSeleccionado = value;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8DC),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppbarCustom(
              title: 'Editar Receta',
              button: IconButton(
                onPressed: () => context.pushReplacement('/'),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    width: 600,
                    height: 115,
                    child: Card(
                      color: Color(0xffF4A460),
                      child: Center(
                        child: Text(
                          'Edita los datos de la receta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff8B4513),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextfieldCustom(
                    hintText: 'Nombre de la receta',
                    labelText: 'Nombre de la receta',
                    controller: _nombreReceta,
                    backgroundColor: const Color(0xffF4A460),
                    isObscure: false,
                    textInputAction: TextInputAction.done,
                    textType: TextInputType.text,
                  ),
                  const SizedBox(height: 40),
                  TextfieldCustomMultiline(
                    hintText: 'Descripción',
                    labelText: 'Descripción',
                    controller: _pasosParaRealizarReceta,
                    backgroundColor: const Color(0xffF4A460),
                  ),
                  const SizedBox(height: 40),
                  TextfieldCustomMultiline(
                    hintText: 'Ingredientes',
                    labelText: 'Ingredientes',
                    controller: _ingredientesReceta,
                    backgroundColor: const Color(0xffF4A460),
                  ),
                  const SizedBox(height: 40),
                  TextfieldCustom(
                    hintText: 'Tiempo de preparación',
                    labelText: 'Tiempo de preparación',
                    controller: _tiempoDePreparacionReceta,
                    backgroundColor: const Color(0xffF4A460),
                    isObscure: false,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _seleccionarTipo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF4A460),
                    ),
                    child: Text(
                      _tipoSeleccionado ?? 'Seleccionar tipo de receta',
                      style: const TextStyle(color: Color(0xff8B4513)),
                    ),
                  ),
                  if (_errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                  const SizedBox(
                    height: 45,
                  ),
                  Botones(
                    onPressed: _salvarCambios,
                    child: const Text('Guardar cambios'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreReceta.dispose();
    _pasosParaRealizarReceta.dispose();
    _ingredientesReceta.dispose();
    _tiempoDePreparacionReceta.dispose();
    super.dispose();
  }
}
