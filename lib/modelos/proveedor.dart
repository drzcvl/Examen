import 'dart:convert';

class ProveedorList {
  List<Proveedor> proveedores;

  ProveedorList({required this.proveedores});

  factory ProveedorList.fromJson(String str) {
    var data = json.decode(str);
    List<dynamic> listadoJson = data['Listado'] ?? [];
    List<Proveedor> proveedoresList =
        listadoJson.map((item) => Proveedor.fromJson(item)).toList();
    return ProveedorList(proveedores: proveedoresList);
  }
}

class Proveedor {
  final int id;
  final String name;
  final String lastName;
  final String mail;
  final String state;

  Proveedor({
    required this.id,
    required this.name,
    required this.lastName,
    required this.mail,
    required this.state,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      id: json['provider_id'],
      name: json['provider_name'],
      lastName: json['provider_last_name'],
      mail: json['provider_mail'],
      state: json['provider_state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_id': id,
      'provider_name': name,
      'provider_last_name': lastName,
      'provider_mail': mail,
      'provider_state': state,
    };
  }
}
