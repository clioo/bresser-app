// To parse this JSON data, do
//
//     final UsuarioModel = usuarioFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    String id;
    String nombre;
    String apellido;
    String telefono;
    int tipo;
    String agente_id;
    String foto;
    String correo;
    String contrasena;
    List<dynamic> favoritos;

    UsuarioModel({
        this.id,
        this.nombre,
        this.apellido,
        this.telefono,
        this.tipo,
        this.agente_id,
        this.foto,
        this.correo,
        this.contrasena,
        this.favoritos
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        tipo: json["tipo"],
        agente_id: json["agente_id"],
        foto: json["foto"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        favoritos: json["favoritos"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "tipo": tipo,
        "agente_id": agente_id,
        "foto": foto,
        "correo": correo,
        "contrasena": contrasena,
        "favoritos": favoritos
    };
}
