import 'package:flutter/material.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  List<dynamic> list;
  CardImageList(this.list);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 350.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: _crearLista(),
      ),
    );
  }

  List<Widget> _crearLista(){
    List<Widget> list = [];
    this.list.forEach((foto){
      list.add(new CardImage(foto));
    });
    return list.toList();
  }

}