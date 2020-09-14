import 'package:chat_110920/widget/boton_azul.dart';
import 'package:chat_110920/widget/custom_imput.dart';
import 'package:chat_110920/widget/labels_login.dart';
import 'package:chat_110920/widget/logo_login.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {

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
                    titulo: 'Registrarse',
                    imagen: 'assets/user.png',
                  ),

                  _Form(),

                  Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes Cuenta?',
                    subtitulo: 'Iniciar secion con tu cuenta!', 
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

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column(
         children: [
           CustomInput(
             icon: Icons.perm_identity,
             placeholder: 'Nombre',
             keyboardType: TextInputType.name,
             textController: nameCtrl,
           ),

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
            text: 'Registrar',
            onPressed: (){
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          )
       ],
      ),
    );
  }
}

















