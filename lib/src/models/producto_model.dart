// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String propietarioId;
    double precio;
    String titulo;
    String descripcion;
    String tipoVenta;
    String domicilio;
    String cp;
    bool estado;
    List<dynamic> imagenes;
    double latitud;
    double longitud;

    ProductoModel({
        this.id,
        this.propietarioId,
        this.precio = 0,
        this.titulo = "",
        this.descripcion,
        this.tipoVenta,
        this.domicilio,
        this.cp,
        this.estado = true,
        this.imagenes,
        this.latitud,
        this.longitud
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        propietarioId: json["propietario_id"],
        precio: json["precio"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        tipoVenta: json["tipo_venta"],
        domicilio: json["domicilio"],
        cp: json["cp"],
        estado: json["estado"],
        imagenes: json["imagenes"],
        latitud: json["latitud"],
        longitud: json["longitu"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "propietario_id": propietarioId,
        "precio": precio,
        "titulo": titulo,
        "descripcion": descripcion,
        "tipo_venta": tipoVenta,
        "domicilio": domicilio,
        "cp": cp,
        "estado": estado,
        "imagenes": imagenes,
        "latitud": latitud,
        "longitud": longitud,
    };
}
