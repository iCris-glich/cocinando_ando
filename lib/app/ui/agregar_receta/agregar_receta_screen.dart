import 'package:cocinando_ando/app/ui/agregar_receta/agregarReceta_controller.dart';
import 'package:cocinando_ando/app/widgets/appBar_custom.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/drawe_custom.dart';
import 'package:cocinando_ando/app/widgets/textField_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgregarRecetaScreen extends StatefulWidget {
  const AgregarRecetaScreen({super.key});

  @override
  State<StatefulWidget> createState() => StateAgregar();
}

class StateAgregar extends State<AgregarRecetaScreen> {
  final TextEditingController _nombreReceta = TextEditingController();
  final TextEditingController _pasosParaRealizarReceta =
      TextEditingController();
  final TextEditingController _ingredientesReceta = TextEditingController();
  final TextEditingController _tiempoDePreparacionReceta =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Variable para almacenar el tipo seleccionado
  String? _tipoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DraweCustom(),
      backgroundColor: const Color(0xffFFF8DC),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppbarCustom(
              title: 'Cocinando Ando',
              button: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
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
                      color: Color(0xffE8C598),
                      child: Center(
                        child: Text(
                          'Llena las casillas con los datos que se piden',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff5D3A1A),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextfieldCustom(
                    hintText: 'Nombre de la receta',
                    labelText: 'Nombre de la receta',
                    controller: _nombreReceta,
                    backgroundColor: const Color(0xffFFFFFF),
                    isObscure: false,
                    textInputAction: TextInputAction.done,
                    textType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextfieldCustomMultiline(
                    hintText: 'Pasos para realizar receta',
                    labelText: 'Pasos para realizar receta',
                    controller: _pasosParaRealizarReceta,
                    backgroundColor: const Color(0xffFFFFFF),
                  ),
                  const SizedBox(height: 20),
                  TextfieldCustomMultiline(
                    hintText: 'Ingredientes',
                    labelText: 'Ingredientes',
                    controller: _ingredientesReceta,
                    backgroundColor: const Color(0xffFFFFFF),
                  ),
                  const SizedBox(height: 20),
                  TextfieldCustom(
                    hintText: 'Tiempo de preparación',
                    labelText: 'Tiempo de preparación',
                    controller: _tiempoDePreparacionReceta,
                    backgroundColor: const Color(0xffFFFFFF),
                    isObscure: false,
                    textInputAction: TextInputAction.done,
                    textType: TextInputType.text,
                  ),
                  const SizedBox(height: 40),
                  // Botón para seleccionar tipo de receta
                  Botones(
                    onPressed: () async {
                      await seleccionTipo(context).then((_) {
                        setState(() {});
                      });
                    },
                    child: const Text(
                      'Selecciona el tipo de receta',
                      style: TextStyle(
                        color: Color(0xff4A2C18),
                      ),
                    ),
                  ),
                  if (_tipoSeleccionado != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Tipo seleccionado: $_tipoSeleccionado',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  const SizedBox(height: 45),
                  Botones(
                    onPressed: () async {
                      if (_nombreReceta.text.isEmpty ||
                          _pasosParaRealizarReceta.text.isEmpty ||
                          _ingredientesReceta.text.isEmpty ||
                          _tiempoDePreparacionReceta.text.isEmpty ||
                          _tipoSeleccionado == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Por favor llena todos los campos')),
                        );
                        return;
                      }

                      agregarReceta(
                        _nombreReceta.text,
                        _pasosParaRealizarReceta.text,
                        _ingredientesReceta.text,
                        _tiempoDePreparacionReceta.text,
                        _tipoSeleccionado!,
                      );
                      context.go('/');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          color: Color(0xff4A2C18),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Guardar receta',
                          style: TextStyle(
                            color: Color(0xff4A2C18),
                          ),
                        ),
                      ],
                    ),
                  )
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

  Future<void> seleccionTipo(BuildContext context) async {
    // Lista de tipos de recetas
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
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
