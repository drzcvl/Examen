import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registro_pantalla.dart';
import '../widgets/base_layout.dart';
import 'inicio.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _estaLogeado = false;

  @override
  void initState() {
    super.initState();
    _verificarEstadoLogin();
  }

  void _verificarEstadoLogin() {
    setState(() {
      _estaLogeado = (_auth.currentUser != null);
    });
  }

  Future<void> _login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Inicio de sesión exitoso!')));
        Navigator.pushReplacement(
          // Cambio aquí
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InicioPantalla()), // ir a la pantalla de inicio
        );
      });
    } catch (e) {}
  }

  Future<void> _cerrarSesion() async {
    await _auth.signOut();
    _verificarEstadoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseLayout(
        title: 'Inicia sesión',
        usuarioConectado: _estaLogeado,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _estaLogeado
              ? _construirUIUsuarioConectado()
              : _construirUIUsuarioNoConectado(),
        ),
      ),
    );
  }

  Widget _construirUIUsuarioConectado() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Ya estás conectado!'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _cerrarSesion,
          child: Text('Cerrar sesión'),
        ),
      ],
    );
  }

  Widget _construirUIUsuarioNoConectado() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Correo electrónico'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Contraseña'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: Text('Iniciar sesión'),
        ),
        SizedBox(height: 20),
        Text('¿No tienes cuenta?'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistroScreen()),
            );
          },
          child: Text('Regístrate aquí'),
        ),
      ],
    );
  }
}
