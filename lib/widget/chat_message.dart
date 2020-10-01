import 'package:chat_110920/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key, 
    @required this.texto, 
    @required this.uid, 
    @required this.animationController
    }) : super(key: key);
  
  
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOutQuad),
                      child: Container(
        
        child: this.uid == authService.usuario.uid
        ? _myMessage()
        : _notMyMessage(),
      ),
          ),
    );
  }



  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 8),
        padding: EdgeInsets.all(8.0),
        child: Text(this.texto, style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(10)
        ),
        
      )
    );
  }


  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        
        margin: EdgeInsets.only(bottom: 5, left: 8, right: 50),
        padding: EdgeInsets.all(8.0),
        child: Text(this.texto, style: TextStyle(color: Colors.black87),),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10)
        ),
        
      )
    );
  }
}