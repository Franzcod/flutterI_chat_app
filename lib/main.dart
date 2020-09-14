import 'package:flutter/material.dart';
import 'package:chat_110920/routes/routes.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',

      /// DATO: Las rutas estan en otro archivo (routes.dart) 


      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}