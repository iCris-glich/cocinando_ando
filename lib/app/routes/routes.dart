import 'package:cocinando_ando/app/ui/agregar_receta/agregar_receta_screen.dart';
import 'package:cocinando_ando/app/ui/crear_usuario/crear_usuario.dart';
import 'package:cocinando_ando/app/ui/datos_receta/datos_receta.dart';
import 'package:cocinando_ando/app/ui/editar_receta/editar_receta.dart';
import 'package:cocinando_ando/app/ui/home/home_screen.dart';
import 'package:cocinando_ando/app/ui/iniciar_sesion/iniciar_sesion.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, value) => HomeScreen(),
    ),
    GoRoute(
      path: '/agregar',
      builder: (context, value) => const AgregarRecetaScreen(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, value) => const AuthUsuario(),
    ),
    GoRoute(
      path: '/sesion',
      builder: (context, value) => const IniciarSesion(),
    ),
    GoRoute(
      path: '/datos/:recetaId', // Usamos :recetaId como parámetro en la ruta
      builder: (context, value) {
        final recetaId = value.pathParameters[
            'recetaId']!; // Obtener recetaId desde los parámetros
        return DatosReceta(
            recetaId: recetaId); // Pasamos recetaId a la pantalla
      },
    ),
    GoRoute(
      path: '/editar',
      builder: (context, value) => const EditarReceta(),
    ),
  ],
);
