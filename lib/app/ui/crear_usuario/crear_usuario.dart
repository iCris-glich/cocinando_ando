import 'package:cocinando_ando/app/ui/crear_usuario/crear_usuario_controller.dart';
import 'package:cocinando_ando/app/widgets/botones.dart';
import 'package:cocinando_ando/app/widgets/textField_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthUsuario extends StatefulWidget {
  const AuthUsuario({super.key});

  @override
  State<StatefulWidget> createState() {
    return StateUsuario();
  }
}

class StateUsuario extends State<AuthUsuario> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  final TextEditingController _usuario = TextEditingController();

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
                  'Crea un usuario para iniciar sesion',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff8B4513),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextfieldCustom(
                  hintText: 'Email',
                  labelText: 'Email',
                  controller: _email,
                  backgroundColor: Color(0xffFFFFFF),
                  isObscure: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextfieldCustom(
                  hintText: 'Usuario',
                  labelText: 'Usuario',
                  controller: _usuario,
                  backgroundColor: Color(0xffFFFFFF),
                  isObscure: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextfieldCustom(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  controller: _contrasena,
                  backgroundColor: Color(0xffFFFFFF),
                  isObscure: true,
                ),
                const SizedBox(
                  height: 35,
                ),
                Botones(
                  onPressed: () {
                    crearUsuario(
                      _email.text,
                      _contrasena.text,
                      _usuario.text,
                    );
                    context.go('/');
                  },
                  child: const Text('Crear usuario'),
                ),
                TextbutonCustom(
                    onPressed: () {
                      context.go('/sesion');
                    },
                    widget: const Text('¿Ya tienes un usuario?')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
