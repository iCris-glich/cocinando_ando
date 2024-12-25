import 'package:cocinando_ando/app/ui/iniciar_sesion/iniciar_sesion_controller.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/textField_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateIniciarSesion();
  }
}

class StateIniciarSesion extends State<IniciarSesion> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8DC),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Pon tus datos para iniciar sesión',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff8B4513),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextfieldCustom(
                  controller: _email,
                  hintText: 'Email',
                  labelText: 'Email',
                  backgroundColor: Colors.black45,
                  isObscure: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextfieldCustom(
                  controller: _contrasena,
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  backgroundColor: Colors.black45,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Botones(
                  onPressed: () async {
                    await iniciarSesion(_email.text, _contrasena.text);
                    context.go('/');
                  },
                  child: const Text('Iniciar Sesion'),
                ),
                TextbutonCustom(
                  onPressed: () {
                    context.go('/registro');
                  },
                  widget: const Text('¿No tienes una cuenta?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
