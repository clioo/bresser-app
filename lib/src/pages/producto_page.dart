import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'widgets/card_image_list.dart';


class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null ) {
      producto = prodData;
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
                _crearDescripcion(),
                _crearPrecio(),
                _crearDisponible(),
                _crearDomicilio(),
                _crearCP(),
                _crearBoton(_submit, 'Actualizar', Icon( Icons.save )),
                _crearBoton(_subirNuevaFoto, 'Subir foto', Icon(Icons.image)),
                _botonMapa()
              ],
            ),
          ),
        ),
      ),
    ); 

  }

  Widget _crearNombre() {

    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Título'
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );

  }
  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: producto.descripcion,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Descripción'
      ),
      onSaved: (value) => producto.descripcion = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Requerido';
        } else {
          return null;
        }
      },
    );

  }
  Widget _crearDomicilio() {
    return TextFormField(
      initialValue: producto.domicilio,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Domicilio'
      ),
      onSaved: (value) => producto.domicilio = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );

  }
  Widget _crearCP() {

    return TextFormField(
      initialValue: producto.cp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Código postal'
      ),
      onSaved: (value) => producto.cp = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );

  }
  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.precio.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => producto.precio = double.parse(value),
      validator: (value) {

        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }

      },
    );
  }
  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.estado,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value)=> setState((){
        producto.estado = value;
      }),
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
    if ( producto.imagenes.length != 0 ) {
      return Stack(
      children: <Widget>[
        CardImageList(producto.imagenes)
      ],);
    } else {
      return Image(
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }
  Widget _botonMapa() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Cómo llegar'),
      icon: Icon(Icons.map),
      onPressed: ( ) => openMap(producto.latitud, producto.longitud),
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  void _submit() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    setState(() {_guardando = true; });
    // if ( foto != null ) {
    //   producto.imagenes.add(await productoProvider.subirImagen(foto));
    // }
    productoProvider.editarProducto(producto);
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
  void _subirNuevaFoto() async{
    var foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    String utl =await productoProvider.subirImagen(producto,foto);
    setState(() {
      
    });
  }

}



