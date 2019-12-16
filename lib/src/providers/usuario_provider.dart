import 'package:formvalidation/src/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioProvider {
  final databaseReference = Firestore.instance;

  Future<List<UsuarioModel>> cargarUsuarios() async{
    QuerySnapshot querySnapshot = await databaseReference.collection('Usuarios')
     .where('tipo',isEqualTo: 3).getDocuments();
    List documentsList = querySnapshot.documents;
    List<UsuarioModel> usuarios = List<UsuarioModel>();
    documentsList.forEach((document){
      print(document);
        UsuarioModel usuario = new UsuarioModel(
          id: document.documentID,
          nombre: document["nombre"],
          apellido: document["apellido"],
          correo: document["correo"],
          foto: document["foto"],
          agente_id: document["agente_id"],
          contrasena: document["contraseña"],
          telefono: document["telefono"],
          tipo: document["tipo"], //1 = vendedor 2 = agente 3 = cliente
          favoritos: document["favoritos"]
        );
        usuarios.add(usuario);
      });
    return usuarios;
  }

  Future<bool> editarUsuario(UsuarioModel usuario)async{
    await databaseReference.collection('Usuarios').document(usuario.id).updateData(
      usuario.toJson(),
    );
    return true;
  }

  Future<QuerySnapshot> login()
  {
    return databaseReference.collection('Usuarios').where('tipo', isEqualTo: 2)
    .getDocuments();
  }
}