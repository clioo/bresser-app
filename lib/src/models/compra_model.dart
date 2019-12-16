// To parse this JSON data, do
//
//     final compra = compraFromJson(jsonString);

import 'dart:convert';

Compra compraFromJson(String str) => Compra.fromJson(json.decode(str));

String compraToJson(Compra data) => json.encode(data.toJson());

class Compra {
    int id;
    int propiedadId;
    int clienteId;
    String precioVenta;

    Compra({
        this.id,
        this.propiedadId,
        this.clienteId,
        this.precioVenta,
    });

    factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        id: json["id"],
        propiedadId: json["propiedad_id"],
        clienteId: json["cliente_id"],
        precioVenta: json["precio_venta"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "propiedad_id": propiedadId,
        "cliente_id": clienteId,
        "precio_venta": precioVenta,
    };
}
