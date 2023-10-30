import 'package:flutter/material.dart';
import '../modelos/producto.dart';
import '../servicios/api_servicio.dart';

class EditarProducto extends StatefulWidget {
  final Producto producto;

  EditarProducto({required this.producto});

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late double price;
  late String image;
  late String state;

  @override
  void initState() {
    super.initState();

    name = widget.producto.name;
    price = widget.producto.price;
    image = widget.producto.image;
    state = widget.producto.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del producto';
                  }
                  return null;
                },
                onSaved: (value) => name = value ?? '',
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el precio del producto';
                  }
                  return null;
                },
                onSaved: (value) => price = double.tryParse(value ?? '') ?? 0,
              ),
              TextFormField(
                initialValue: image,
                decoration: InputDecoration(labelText: 'Imagen URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la URL de la imagen';
                  }
                  return null;
                },
                onSaved: (value) => image = value ?? '',
              ),
              TextFormField(
                initialValue: state,
                decoration: InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el estado del producto';
                  }
                  return null;
                },
                onSaved: (value) => state = value ?? '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _editarProducto();
                    }
                  },
                  child: Text('Guardar Cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editarProducto() async {
    Producto productoActualizado = Producto(
      id: widget.producto.id,
      name: name,
      price: price,
      image: image,
      state: state,
    );

    try {
      await ApiServicio().editProducto(productoActualizado);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al editar el producto')),
      );
    }
  }
}
