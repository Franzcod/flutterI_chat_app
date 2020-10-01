import 'package:chat_110920/services/auth_service.dart';
import 'package:chat_110920/services/chat_service.dart';
import 'package:chat_110920/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_110920/routes/routes.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Como se usa Provider para manejar estados se pone el MaterialApp entro de un MultiProvider
    return MultiProvider(
        providers: [ 
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => SocketService()),
          ChangeNotifierProvider(create: (_) => ChatService()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',

          /// DATO: Las rutas estan en otro archivo (routes.dart) 

          initialRoute: 'loading',
          routes: appRoutes,
        ),
    );
  }
}

