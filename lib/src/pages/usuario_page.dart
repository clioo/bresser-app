import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/usuario_model.dart';
import 'package:formvalidation/src/pages/widgets/card_image.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';

class UsuarioPage extends StatefulWidget {
  UsuarioPage({Key key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final usuarioProvider = new UsuarioProvider();
  UsuarioModel usuario = new UsuarioModel();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final UsuarioModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      usuario = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Inmueble'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearApellido(),
                _crearCorreo(),
                _crearTelefono(),
                _crearBoton(_submit, 'Actualizar', Icon( Icons.save )),
                RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    label: Text('Intereses'),
                    icon: Icon( Icons.favorite ),
                    onPressed: (){
                      Navigator.pushNamed(context, 'productos', arguments: usuario.favoritos);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {

    return TextFormField(
      initialValue: usuario.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre'
      ),
      onSaved: (value) => usuario.nombre = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Requerido';
        } else {
          return null;
        }
      },
    );

  }
  Widget _crearApellido() {

    return TextFormField(
      initialValue: usuario.apellido,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Apellido'
      ),
      onSaved: (value) => usuario.apellido = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Requerido';
        } else {
          return null;
        }
      },
    );

  }  
  Widget _crearCorreo() {
    return TextFormField(
      initialValue: usuario.correo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Correo'
      ),
      onSaved: (value) => usuario.correo = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Requerido';
        } else {
          return null;
        }
      },
    );

  }  
  Widget _crearTelefono() {
    return TextFormField(
      initialValue: usuario.telefono,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Teléfono'
      ),
      onSaved: (value) => usuario.telefono = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Requerido';
        } else {
          return null;
        }
      },
    );

  }  
  Widget _crearBoton(Function function, String text, Icon icon) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text(text),
      icon: icon,
      onPressed: ( _guardando ) ? null : function,
    );
  }
  Widget _mostrarFoto() {
    if ( usuario.foto != null ) {
      return Stack(
      children: <Widget>[
        CardImage(usuario.foto)
      ],);
    } else {
      return Image(
        image: AssetImage('assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _submit() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    setState(() {_guardando = true; });
    usuarioProvider.editarUsuario(usuario);
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);

  }
  void mostrarSnackbar(String mensaje) {

    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

  }
  void _mostrarIntereses(BuildContext context){
    ProductosProvider productosProvider = new ProductosProvider();
    
  }


}