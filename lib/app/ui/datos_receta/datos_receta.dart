import 'package:cocinando_ando/app/ui/datos_receta/datos_controller.dart';
import 'package:cocinando_ando/app/widgets/appBar_custom.dart';
import 'package:cocinando_ando/app/widgets/drawe_custom.dart';
import 'package:flutter/material.dart';

class DatosReceta extends StatefulWidget {
  final String? recetaId;

  const DatosReceta({super.key, this.recetaId});

  @override
  State<StatefulWidget> createState() {
    return DatosRecetaState();
  }
}

class DatosRecetaState extends State<DatosReceta> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DraweCustom(),
      backgroundColor: const Color(0xffFFF8DC),
      key: _scaffoldKey,
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
            child: DatosController(recetaId: widget.recetaId),
          ),
        ],
      ),
    );
  }
}
