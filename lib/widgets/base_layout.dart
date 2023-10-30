import 'package:flutter/material.dart';
import '../pantallas/login.dart';
import '../pantallas/ProductoPantalla.dart';
import '../pantallas/ProveedorPantalla.dart';
import '../pantallas/CategoriaPantalla.dart';
import '../pantallas/inicio.dart';
// Importa otras pantallas aquí

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool usuarioConectado;

  BaseLayout(
      {required this.child,
      required this.title,
      this.usuarioConectado = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(usuarioConectado ? Icons.person : Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menú Principal'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicioPantalla()),
                );
              },
            ),
            ListTile(
              title: Text('Productos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductoPantalla()),
                );
              },
            ),
            ListTile(
              title: Text('Proveedores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProveedorPantalla()),
                );
              },
            ),
            ListTile(
              title: Text('Categorías'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriaPantalla()),
                );
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
