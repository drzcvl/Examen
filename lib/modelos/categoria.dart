import 'dart:convert';

class CategoriaList {
  List<Categoria> categorias;

  CategoriaList({required this.categorias});

  factory CategoriaList.fromJson(String str) {
    var data = json.decode(str);
    List<dynamic> listadoJson = data['Listado'] ?? [];
    List<Categoria> categoriasList =
        listadoJson.map((item) => Categoria.fromJson(item)).toList();
    return CategoriaList(categorias: categoriasList);
  }
}

class Categoria {
  final int id;
  final String name;
  final String state;

  Categoria({
    required this.id,
    required this.name,
    required this.state,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['category_id'],
      name: json['category_name'],
      state: json['category_state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'category_name': name,
      'category_state': state,
    };
  }
}
