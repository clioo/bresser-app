import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/pages/clientes_page.dart';

import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final _pageOptions = [
      _crearListado(),
      ClientesPage()
    ];
    

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Inmuebles'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Clientes')
          ),
        ],
        onTap: (int index){
          setState((){
            _selectedPage = index;
          });
        },
      ),
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _pageOptions[_selectedPage],
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

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'producto'),
    );
  }

}