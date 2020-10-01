import 'package:chat_110920/global/environment.dart';
import 'package:chat_110920/models/mensajes_response.dart';
import 'package:chat_110920/models/usuario.dart';
import 'package:chat_110920/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatService with ChangeNotifier{


  Usuario usuarioPara;


  Future<List<Mensaje>> getChat( String usuarioID ) async {

    final resp = await http.get('${Environment.apiUrl}/mensajes/$usuarioID',
    headers: {
      'Content-Type':  'application/json',
      'x-token': await AuthService.getToken()
    });


    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.mensajes;

  }



}