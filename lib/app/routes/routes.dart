import 'package:cocinando_ando/app/ui/agregar_receta/agregar_receta_screen.dart';
import 'package:cocinando_ando/app/ui/crear_usuario/crear_usuario.dart';
import 'package:cocinando_ando/app/ui/datos_receta/datos_receta.dart';
import 'package:cocinando_ando/app/ui/editar_receta/editar_receta.dart';
import 'package:cocinando_ando/app/ui/home/home_screen.dart';
import 'package:cocinando_ando/app/ui/iniciar_sesion/iniciar_sesion.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/agregar',
      builder: (context, state) => const AgregarRecetaScreen(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => const AuthUsuario(),
    ),
    GoRoute(
      path: '/sesion',
      builder: (context, state) => const IniciarSesion(),
    ),
    GoRoute(
      path: '/datos/:recetaId',
      builder: (context, state) {
        final recetaId = state.pathParameters['recetaId']!;
        return DatosReceta(recetaId: recetaId);
      },
    ),
    GoRoute(
      path: '/editar/:recetaId',
      builder: (context, state) {
        final recetaId = state.pathParameters['recetaId'];
        if (recetaId == null) {
          return const Scaffold(
              body: Center(child: Text('Error: No se proporcionó recetaId')));
        }
        return EditarReceta(recetaId: recetaId);
      },
    ),
  ],
);
