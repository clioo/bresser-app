import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/usuario_model.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';

class ClientesPage extends StatefulWidget {


  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<ClientesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  final bottomPages = [
    
  ];
  @override
  Widget build(BuildContext context) {
    return _crearListado();
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: usuarioProvider.cargarUsuarios(),
      builder: (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
        if ( snapshot.hasData ) {

          final usuarios = snapshot.data;

          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, i) => _crearItem(context, usuarios[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, UsuarioModel usuario ) {
    return Card(
        child: Column(
          children: <Widget>[

            ( usuario.foto == null ) 
              ? Image(image: AssetImage('assets/no-image.png'))
              : FadeInImage(
                image: NetworkImage( usuario.foto ),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            
            ListTile(
              title: Text('${ usuario.nombre } ${ usuario.apellido }'),
              subtitle: Text( usuario.telefono ),
              onTap: () => Navigator.pushNamed(context, 'usuario', arguments: usuario ),
            ),

          ],
        ),
      );


    

  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'usuario'),
    );
  }



}