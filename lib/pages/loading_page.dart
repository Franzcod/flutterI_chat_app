
import 'package:chat_110920/pages/usuarios_page.dart';
import 'package:chat_110920/services/auth_service.dart';
import 'package:chat_110920/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot){
          return  Center(
            child: SizedBox(
              height: 100.0,
              width: 100.0,
              child: 
                  CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 20.0)
            )
          );
        },
      ),
   );
  }

  Future checkLoginState(BuildContext context) async{

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen:false);

    final autenticado = await authService.isLoggedIn();

    if(autenticado){
      // Navigator.pushReplacementNamed(context, 'usuarios');
      socketService.connect();
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __ , ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 2000),
        )
      );
    } else{
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __ , ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 2000),
        )
      );
    }

  }
}