import 'package:chat_110920/services/auth_service.dart';
import 'package:chat_110920/services/socket_service.dart';
import 'package:chat_110920/widget/boton_azul.dart';
import 'package:chat_110920/widget/custom_imput.dart';
import 'package:chat_110920/widget/labels_login.dart';
import 'package:chat_110920/widget/logo_login.dart';
import 'package:chat_110920/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2), /// Color Gris  Color(0xffF2F2F2)
      body: SafeArea(

        ///Para que no de el error del espacio se pone en un scroll
        
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Logo(
                    titulo: 'ChatRoom',
                    imagen: 'assets/logo-chat.png',
                  ),

                  _Form(),

                  Labels(
                    ruta: 'register',
                    titulo: '¿No tienes Cuenta?',
                    subtitulo: 'Crear una Cuenta!', 
                  ),

                  Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
                ],
            ),
          ),
        ),
      )
   );
  }
}




class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
       child: Column(
         children: <Widget>[
           
           CustomInput(
                  icon: Icons.mail_outline,
                  placeholder: 'Correo',
                  keyboardType: TextInputType.emailAddress,
                  textController: emailCtrl,
                ),

                CustomInput(
                  icon: Icons.lock_outline,
                  placeholder: 'Contrseña',
                  textController: passCtrl,
                  isPassword: true,
                ),
        
                BotonAzul(
                  text: 'Ingrese',

                  // si se esta autenticando el boton azul se pone en null y se desabilita
                  onPressed: authService.autenticando ? null : ()  async {
                    
                    ///Sacar el teclado
                    FocusScope.of(context).unfocus();

                    /// ".trim()" para que no vayan espacios en blanco!!!
                    final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                    if(loginOk){
                      /// conectar al socket server
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                      
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, 'Ups!', 'Usuario  o Contraseña son incorrectos');
                    }
                  },
                )
              ],
          ),
      
    );
  }
}

















