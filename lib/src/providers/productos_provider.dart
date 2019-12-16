
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  final databaseReference = Firestore.instance;


  Future<bool> crearProducto( ProductoModel producto ) async {


    return true;

  }

  Future<bool> editarProducto( ProductoModel producto ) async {
    await databaseReference.collection('Propiedades').document(producto.id).updateData(
      producto.toJson(),
    );
    return true;
  }


  Future<List<ProductoModel>> cargarProductos() async {
    QuerySnapshot querySnapshot = await databaseReference.collection('Propiedades').getDocuments();
    List documentsList = querySnapshot.documents;
    List<ProductoModel> productos = List<ProductoModel>();
    documentsList.forEach((document){
        ProductoModel producto = new ProductoModel(
          id: document.documentID,
          precio:document["precio"].toDouble() ?? 0.0,
          titulo: document["titulo"],
          descripcion: document["descripcion"],
          domicilio: document["domicilio"],
          cp: document["cp"],
          estado: document["estado"],
          imagenes: document["imagenes"],
          latitud: document["latitud"],
          longitud: document["longitud"]
        );
        productos.add(producto);
      });
    return productos;
  }


  Future<int> borrarProducto( String id ) async { 

    
    return 1;
  }
  

  Future<String> subirImagen(ProductoModel producto, File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    List<dynamic> links = List<dynamic>();
    producto.imagenes.forEach((link){
      links.add(link);
    });
    print(respData['secure_url']);
    links.add(respData['secure_url']);
    producto.imagenes = links;
    databaseReference.collection("Propiedades").document(producto.id).updateData(
      producto.toJson()
    );
    return respData['secure_url'];

  }

  Future<ProductoModel> obtenerProducto(String id) async {
    databaseReference.collection('Propiedades').document(id).get()
    .then((DocumentSnapshot document){
      return new ProductoModel(
            id: document.documentID,
            precio:document["precio"].toDouble() ?? 0.0,
            titulo: document["titulo"],
            descripcion: document["descripcion"],
            domicilio: document["domicilio"],
            cp: document["cp"],
            estado: document["estado"],
            imagenes: document["imagenes"],
          );
    });

  }


}

