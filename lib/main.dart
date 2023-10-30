import 'package:flutter/material.dart';
import '/pantallas/login.dart';
import '/pantallas/inicio.dart';
import '/estado_global.dart'; // Asegúrate de que la ruta sea correcta
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ValueListenableBuilder<bool>(
        valueListenable: usuarioConectado,
        builder: (context, estaConectado, child) {
          if (estaConectado) {
            return InicioPantalla(); // Pantalla de inicio después del login
          } else {
            return LoginScreen(); // Pantalla de login
          }
        },
      ),
      // P
    );
  }
}
