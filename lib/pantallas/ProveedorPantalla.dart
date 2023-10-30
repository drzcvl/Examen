import 'package:flutter/material.dart';
import '../modelos/proveedor.dart';
import '../servicios/api_servicio.dart';
import '../widgets/base_layout.dart';

class ProveedorPantalla extends StatefulWidget {
  @override
  _ProveedorPantallaState createState() => _ProveedorPantallaState();
}

class _ProveedorPantallaState extends State<ProveedorPantalla> {
  late List<Proveedor> proveedores;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProveedores();
  }

  fetchProveedores() async {
    try {
      proveedores = await ApiServicio().getProveedores();
      setState(() => isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Proveedores',
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = proveedores[index];
                return ListTile(
                  title: Text(proveedor.name),
                  subtitle: Text('Correo: ${proveedor.mail}'),
                  onTap: () {
                    // aca deberia poner el detalle
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // aca para eliminar el proveedor
                    },
                  ),
                );
              },
            ),
    );
  }
}
