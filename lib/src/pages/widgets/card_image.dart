import 'package:flutter/material.dart';

class  CardImage extends StatelessWidget {

  String imageUrl = "assets/img/beach.jpeg";

  CardImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
      height: 350.0,
      width: 250.0,
      margin: EdgeInsets.only(
        top: 20.0,
        left: 20.0

      ),

      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
            image: NetworkImage(imageUrl)
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow (
            color:  Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0)
          )
        ]

      ),
    );

    return card;
  }

}