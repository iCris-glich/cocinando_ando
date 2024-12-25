import 'package:cocinando_ando/app/routes/routes.dart';
import 'package:cocinando_ando/app/services/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    Logger().e('Error $e');
  }
  runApp(const CocinandoAndo());
}

class CocinandoAndo extends StatelessWidget {
  const CocinandoAndo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cocinando Ando',
      routerConfig: router,
      theme: ThemeData(
        primaryColor: const Color(0xffD2691E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffD2691E),
        ),
      ),
    );
  }
}
