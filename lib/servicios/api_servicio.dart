import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modelos/proveedor.dart';
import '../modelos/categoria.dart';
import '../modelos/producto.dart';

class ApiServicio extends ChangeNotifier {
  final String _baseUrl = "143.198.118.203:8000";
  final String _user = "test";
  final String _pass = "test2023";
  bool isLoading = false;

  String _getBasicAuth() {
    return 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
  }

  // Productos

  Future<List<Producto>> getProductos() async {
    final url = Uri.http(_baseUrl, '/ejemplos/product_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      final productList = ProductoList.fromJson(response.body);
      return productList.productos;
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  Future<void> addProducto(Producto producto) async {
    final url = Uri.http(_baseUrl, '/ejemplos/product_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode(producto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar producto');
    }
  }

  Future<void> editProducto(Producto producto) async {
    final url = Uri.http(_baseUrl, '/ejemplos/product_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode(producto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar producto');
    }
  }

  Future<void> deleteProducto(int id) async {
    final url = Uri.http(_baseUrl, '/ejemplos/product_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode({'product_id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar producto');
    }
    getProductos(); // Recargar la lista de produc
  }

  // Listar todas las categorías
  Future<List<Categoria>> getCategorias() async {
    final response = await http.get(
        Uri.http(_baseUrl, "ejemplos/category_list_rest/"),
        headers: {'authorization': _getBasicAuth()});

    if (response.statusCode == 200) {
     
      final categoriaList = CategoriaList.fromJson(response.body);
      return categoriaList.categorias;
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  Future<void> addCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.http(_baseUrl, "ejemplos/category_add_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode(categoria.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al agregar categoría');
    }
    getCategorias(); // Recargar la lista de categorías
  }

  Future<void> editCategoria(Categoria categoria) async {
    final response = await http.put(
      Uri.http(_baseUrl, "/ejemplos/category_edit_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode(categoria.toJson()),
    );

    if (response.statusCode == 200) {
      getCategorias(); // Recargar la lista de categorías
    } else {
      throw Exception('Error al editar categoría');
    }
  }

  Future<void> deleteCategoria(int id) async {
    final response = await http.post(
      Uri.http(_baseUrl, "ejemplos/category_del_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode({'category_id': id}),
    );

    if (response.statusCode == 200) {
      getCategorias(); // Recargar la lista de categorías
    } else {
      throw Exception('Error al eliminar categoría');
    }
  }

  // Listar todos los proveedores

  Future<List<Proveedor>> getProveedores() async {
    final response = await http.get(
        Uri.http(_baseUrl, "ejemplos/category_list_rest/"),
        headers: {'authorization': _getBasicAuth()});

    if (response.statusCode == 200) {
     
      final proveedorlist = ProveedorList.fromJson(response.body);
      return proveedorlist.proveedores;
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  Future<void> addProveedor(Proveedor proveedor) async {
    final response = await http.post(
      Uri.http(_baseUrl, "ejemplos/provider_add_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode(proveedor.toJson()),
    );

    if (response.statusCode == 200) {
      getProveedores(); 
    } else {
      throw Exception('Error al agregar proveedor');
    }
  }

  Future<void> editProveedor(Proveedor proveedor) async {
    final response = await http.put(
     
      Uri.http(_baseUrl, "ejemplos/provider_edit_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode(proveedor.toJson()),
    );

    if (response.statusCode == 200) {
      getProveedores(); // Recargar la lista de proveedores
    } else {
      throw Exception('Error al editar proveedor');
    }
  }

  Future<void> deleteProveedor(int id) async {
    final response = await http.delete(
      
      Uri.http(_baseUrl, "ejemplos/provider_del_rest/"),
      headers: {
        'Content-Type': 'application/json',
        'authorization': _getBasicAuth()
      },
      body: jsonEncode({'provider_id': id}),
    );

    if (response.statusCode == 200) {
      getProveedores(); // Recargar la lista de proveedores
    } else {
      throw Exception('Error al eliminar proveedor');
    }
  }
}
