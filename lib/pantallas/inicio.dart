import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';
import 'ProductoPantalla.dart';
import 'CategoriaPantalla.dart';
import 'ProveedorPantalla.dart';

class InicioPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Inicio',
      usuarioConectado: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centra los widgets en la columna
          children: <Widget>[
            Text('Bienvenido a la página de inicio'),
            SizedBox(height: 20), // Espacio entre texto y botones
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductoPantalla()),
                );
              },
              child: Text('Productos'),
            ),
            SizedBox(height: 10), // Espacio entre botones
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriaPantalla()),
                );
              },
              child: Text('Categorías'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProveedorPantalla()),
                );
              },
              child: Text('Proveedores'),
            ),
          ],
        ),
      ),
    );
  }
}
