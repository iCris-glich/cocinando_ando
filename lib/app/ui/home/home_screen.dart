import 'package:cocinando_ando/app/ui/home/home_controller.dart';
import 'package:cocinando_ando/app/widgets/appBar_custom.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/drawe_custom.dart';
import 'package:cocinando_ando/app/widgets/menuHorizontal.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xffFFF8DC),
      drawer: const DraweCustom(),
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.8, // Ajusta el tamaño
                child:
                    const MostrarRecetas(), // Muestra el widget MostrarRecetas
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingBoton(
        onPressed: () {
          _showMenu(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Menuhorizontal();
      },
    );
  }
}
