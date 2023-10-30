import 'dart:convert';

class ProductoList {
  List<Producto> productos;

  ProductoList({required this.productos});

  factory ProductoList.fromJson(String str) {
    var data = json.decode(str);
    List<dynamic> listadoJson = data['Listado'] ?? [];

    List<Producto> productosList =
        listadoJson.map((item) => Producto.fromJson(item)).toList();

    return ProductoList(productos: productosList);
  }
}

class Producto {
  final int id;
  final String name;
  final double price;
  final String image;
  final String state;

  Producto({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.state,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['product_id'],
      name: json['product_name'],
      price: json['product_price'].toDouble(),
      image: json['product_image'],
      state: json['product_state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'product_name': name,
      'product_price': price,
      'product_image': image,
      'product_state': state,
    };
  }
}
