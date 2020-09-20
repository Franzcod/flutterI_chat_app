import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo){

  if(!Platform.isAndroid){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        
        title: Center(child: Text(titulo, style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold))),
        content: Text(subtitulo, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Volver', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold,),),
            elevation: 5,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(titulo, style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      content: Text(subtitulo, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,)),
      actions: <Widget> [
        CupertinoDialogAction(
          child: Text('Volver'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );

  

  // showDialog(
  //   context: context,
  //   builder: (BuildContext context){
  //     return Dialog(
  //       child: Container(
  //         height: 200,
  //         child: Column(
  //           children: [
  //             TextField(
  //               textAlign: TextAlign.end,
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 // hintText: titulo,
  //                 labelText: titulo,
  //                 labelStyle: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold,), 
  //               )
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: subtitulo
  //               )
  //             )
  //           ],  
  //         )

  //   ),
  // );
  //   }
  // );
  

}