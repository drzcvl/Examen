import 'package:flutter/material.dart';
import '../modelos/producto.dart';

class ProductoDetallePantalla extends StatelessWidget {
  final Producto producto;

  ProductoDetallePantalla({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre: ${producto.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Precio: ${producto.price}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Estado: ${producto.state ?? 'No especificado'}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            producto.image.isNotEmpty
                ? Image.network(producto.image)
                : Text('No hay imagen disponible'),
          ],
        ),
      ),
    );
  }
}
