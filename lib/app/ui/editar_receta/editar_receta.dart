import 'package:cocinando_ando/app/ui/agregar_receta/agregarReceta_controller.dart';
import 'package:cocinando_ando/app/widgets/appBar_custom.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/textField_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditarReceta extends StatefulWidget {
  const EditarReceta({super.key});

  @override
  State<StatefulWidget> createState() => StateAgregar();
}

class StateAgregar extends State<EditarReceta> {
  final TextEditingController _nombreReceta = TextEditingController();
  final TextEditingController _descripcionReceta = TextEditingController();
  final TextEditingController _ingredientesReceta = TextEditingController();
  final TextEditingController _tiempoDePreparacionReceta =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8DC),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppbarCustom(
                title: 'Cocinando Ando',
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
                            'Llena las casillas con los datos que se piden',
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
                    ),
                    const SizedBox(height: 40),
                    TextfieldCustom(
                      hintText: 'Descripción',
                      labelText: 'Descripción',
                      controller: _descripcionReceta,
                      backgroundColor: const Color(0xffF4A460),
                      isObscure: false,
                      textType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 40),
                    TextfieldCustom(
                      hintText: 'Ingredientes',
                      labelText: 'Ingredientes',
                      controller: _ingredientesReceta,
                      backgroundColor: const Color(0xffF4A460),
                      isObscure: false,
                      textType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 40),
                    TextfieldCustom(
                      hintText: 'Tiempo de preparación',
                      labelText: 'Tiempo de preparación',
                      controller: _tiempoDePreparacionReceta,
                      backgroundColor: const Color(0xffF4A460),
                      isObscure: false,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Botones(
                      onPressed: () async {
                        context.go('/');
                      },
                      child: const Text('Guardar receta'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreReceta.dispose();
    _descripcionReceta.dispose();
    _ingredientesReceta.dispose();
    _tiempoDePreparacionReceta.dispose();
    super.dispose();
  }
}
