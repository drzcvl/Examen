import 'package:flutter/material.dart';
import '../servicios/api_servicio.dart';
import '../modelos/producto.dart';
import '../modelos/categoria.dart';
import '../modelos/proveedor.dart';

class ProductProvider with ChangeNotifier {
  List<Producto>? _productos;
  final ApiServicio _apiService = ApiServicio();

  List<Producto>? get productos => _productos;

  // ver productos
  void fetchProductos() async {
    _productos = await _apiService.getProductos();
    notifyListeners();
  }

  // agregar nuevo poducto - no se uso
  Future<void> addProducto(Producto producto) async {
    await _apiService.addProducto(producto);
    fetchProductos();
  }

  // Editar el producto
  Future<void> editProducto(Producto producto) async {
    await _apiService.addProducto(producto);
    fetchProductos();
  }

  // borrar producto
  Future<void> deleteProducto(int id) async {
    await _apiService.deleteProducto(id);
    fetchProductos();
  }
}

class CategoriaProvider with ChangeNotifier {
  List<Categoria>? _categorias;
  final ApiServicio _apiService = ApiServicio();

  List<Categoria>? get categorias => _categorias;

  // Ver categorías
  void fetchCategorias() async {
    _categorias = await _apiService.getCategorias();
    notifyListeners();
  }

  // Agregar nueva categoría
  Future<void> addCategoria(Categoria categoria) async {
    await _apiService.addCategoria(categoria);
    fetchCategorias();
  }

  // Editar categoría
  Future<void> editCategoria(Categoria categoria) async {
    await _apiService.editCategoria(categoria);
    fetchCategorias();
  }

  // Borrar categoría
  Future<void> deleteCategoria(int id) async {
    await _apiService.deleteCategoria(id);
    fetchCategorias();
  }
}

class ProveedorProvider with ChangeNotifier {
  List<Proveedor>? _proveedores;
  final ApiServicio _apiService = ApiServicio();

  List<Proveedor>? get proveedores => _proveedores;

  // Ver proveedores
  void fetchProveedores() async {
    _proveedores = await _apiService.getProveedores();
    notifyListeners();
  }

  // Agregar nuevo proveedor
  Future<void> addProveedor(Proveedor proveedor) async {
    await _apiService.addProveedor(proveedor);
    fetchProveedores();
  }

  // Editar proveedor
  Future<void> editProveedor(Proveedor proveedor) async {
    await _apiService.editProveedor(proveedor);
    fetchProveedores();
  }

  // Borrar proveedor
  Future<void> deleteProveedor(int id) async {
    await _apiService.deleteProveedor(id);
    fetchProveedores();
  }
}
