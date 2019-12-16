import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/usuario_page.dart';

import 'src/pages/productos_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'    : ( BuildContext context ) => LoginPage(),
          'home'     : ( BuildContext context ) => HomePage(),
          'producto' : ( BuildContext context ) => ProductoPage(),
          'usuario'  : ( BuildContext context ) => UsuarioPage(),
          'productos':  ( BuildContext context ) => ProductosPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}