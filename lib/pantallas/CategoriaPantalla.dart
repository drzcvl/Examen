import 'package:flutter/material.dart';
import '../modelos/categoria.dart';
import '../servicios/api_servicio.dart';
import '../widgets/base_layout.dart';

class CategoriaPantalla extends StatefulWidget {
  @override
  _CategoriaPantallaState createState() => _CategoriaPantallaState();
}

class _CategoriaPantallaState extends State<CategoriaPantalla> {
  late List<Categoria> categorias;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategorias();
  }

  fetchCategorias() async {
    try {
      categorias = await ApiServicio().getCategorias();
      setState(() => isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Categorías',
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return ListTile(
                  title: Text(categoria.name),
                  subtitle: Text('Estado: ${categoria.state}'),
                  onTap: () {
                    // aqui deberia poner una patalla detalle
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // aqui deberia poner eliminar la categoria
                    },
                  ),
                );
              },
            ),
    );
  }
}
