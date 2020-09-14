
import 'package:flutter/material.dart';


class Logo extends StatelessWidget {

  final String titulo;

  final String imagen;

  const Logo({
    Key key, 
    @required this.titulo, 
    @required this.imagen
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container (
        
        margin: EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image(image: AssetImage(this.imagen)),
            SizedBox(height: 20),
            Text('QQ', style: TextStyle(fontSize: 25)),
            Text(this.titulo, style: TextStyle(fontSize: 25))
          ],
        )
      ),
    );
  }
 
}