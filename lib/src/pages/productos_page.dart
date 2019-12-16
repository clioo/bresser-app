import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';

import 'package:formvalidation/src/providers/productos_provider.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final productosProvider = new ProductosProvider();
  List<ProductoModel> productos = List<ProductoModel>();
  List<dynamic> favoritos = List<dynamic>();

  @override
  Widget build(BuildContext context) {
  final List<dynamic> prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      favoritos = prodData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Intereses del usuario')
      ),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }
 
  Widget _crearItem(BuildContext context, ProductoModel producto ) {
    return Card(
        child: Column(
          children: <Widget>[

            ( producto.imagenes.length == 0 ) 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: NetworkImage( producto.imagenes[0] ),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            
            ListTile(
              title: Text('${ producto.titulo } - ${ producto.precio }'),
              subtitle: Text( producto.id ),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto ),
            ),

          ],
        ),
      );


    

  }



}