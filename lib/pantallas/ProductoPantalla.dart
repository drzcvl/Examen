import 'package:flutter/material.dart';
import '../modelos/producto.dart';
import '../servicios/api_servicio.dart';
import '../widgets/base_layout.dart';
import 'ProductoDetallePantalla.dart';
import 'editarproducto.dart';

class ProductoPantalla extends StatefulWidget {
  @override
  _ProductoPantallaState createState() => _ProductoPantallaState();
}

class _ProductoPantallaState extends State<ProductoPantalla> {
  late List<Producto> productos;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductos();
  }

  fetchProductos() async {
    try {
      productos = await ApiServicio().getProductos();
      setState(() => isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Productos',
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.name),
                  subtitle: Text('Precio: ${producto.price}'),
                  leading: producto.image.isNotEmpty
                      ? Image.network(producto.image, width: 50, height: 50)
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductoDetallePantalla(producto: producto)),
                    );
                  },
                  trailing: PopupMenuButton<String>(
                    onSelected: (String choice) async {
                      switch (choice) {
                        case 'Editar':
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditarProducto(producto: producto),
                            ),
                          );
                          fetchProductos(); // Recargar la lista después de editar
                          break;
                        case 'Eliminar':
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmar"),
                                content: Text(
                                    "¿Estás seguro de que quieres eliminar este producto?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Eliminar"),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await deleteProducto(producto.id);
                                      fetchProductos();
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return ['Editar', 'Eliminar'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                );
              },
            ),
    );
  }

  deleteProducto(int id) async {
    try {
      await ApiServicio().deleteProducto(id);
    } catch (e) {
      print(e);
    }
  }
}
