import 'dart:io';

import 'package:chat_110920/widget/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _message = [
    // ChatMessage(uid: '123', texto: 'Hola bebe', animationController: null,),
    // ChatMessage(uid: '123', texto: 'Hola bebe',animationController: null),
    // ChatMessage(uid: '444', texto: 'Hola bebe',animationController: null),
    // ChatMessage(uid: '123', texto: 'Hola bebe',animationController: null),
    // ChatMessage(uid: '444', texto: 'Hola bebe',animationController: null),
    // ChatMessage(uid: '444', texto: 'Hola bebe',animationController: null), 
  ];


  bool _estaEscribiendo = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blue,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Icon(Icons.arrow_back_ios, color: Colors.blue[200],),
            SizedBox(width: 10),
            Column(
              children: [
                
                Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 20)),
                SizedBox(height:3),
                Text('Ult. vez hoy a las 14:50', style: TextStyle(color: Colors.black45, fontSize: 15),),
              ],
            ),
            SizedBox(width: 10),

            /// Circle Avatar dentro de otro CircleAvatar para hacerle el bordecito al rededor de la imagen
            CircleAvatar(
              backgroundColor: Colors.blue[200],
              radius: 28,
                child: CircleAvatar(
                backgroundImage: NetworkImage('https://i0.pngocean.com/files/983/153/77/computer-icons-user-profile-female-avatar-user.jpg'),
                backgroundColor: Colors.blue[200],
                radius: 25,
              ),
            ),
          ]
        ),
        centerTitle: true,
        elevation: 5,
      ),

      body: Container(
        
        child: Column(
          
          children: <Widget>[
            Flexible(
              
              child: ListView.builder(
                
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: ( _ , i) => _message[i],
                reverse: true,
              ),
            ),
            Divider(height: 2),
            ///TODO: Caja de Textos
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ]
        )
      ),
   );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( texto){
                  ///TODO: cuando hay un valor para poder postear
                  setState(() {
                    if(texto.trim().length > 0){
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Escribir mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            //Booton de enviar!!
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: _estaEscribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
              )
              
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue),
                                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send), 
                    onPressed: _estaEscribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                  ),
                ),
              ),
            )
          ]
        ),
      )
    );
  }

  _handleSubmit(String texto){


    ///Si el texto esta vacio
    if (texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 500)),
    );
    
    _message.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    for(ChatMessage message in _message){
      message.animationController.dispose();
    }
    super.dispose();
  }
}