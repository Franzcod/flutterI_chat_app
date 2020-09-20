
import 'dart:convert';

import 'package:chat_110920/global/environment.dart';
import 'package:chat_110920/models/login_response.dart';
import 'package:chat_110920/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// AUTENTICACION!!!!!!!!!----------------------------------

class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();


  // variable para saber si esta autenticado, notifica a toda la app con Provider! el estado
  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token en forma estatica

  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  
  //final  

  Future<bool> login(String email, String password) async {

    this.autenticando = true;

    final data = {
      'email' : email,
      'password' : password,
    };

    final resp = await http.post('${Environment.apiUrl}/login', 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      ///TODO: Guardar token en luar seguro
      ///
      await this._guardarToken(loginResponse.token);

      return true;

    } else {


      return false;
    }
    

  }

  Future register(String nombre,String email, String password) async {

    this.autenticando = true;

    final data = {
      'nombre' : nombre,
      'email' : email,
      'password' : password,
    };

    final resp = await http.post('${Environment.apiUrl}/login/new', 
      body: jsonEncode(data),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      ///TODO: Guardar token en luar seguro
      ///
      await this._guardarToken(loginResponse.token);

      return true;

    } else {

      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async{

    final token = await this._storage.read(key: 'token');
    
    final resp = await http.get('${Environment.apiUrl}/login/renew', 
      headers: {
        'Content-Type' : 'application/json',
        'x-token' : token
      }
    );

    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      /// Guardar token en luar seguro
      await this._guardarToken(loginResponse.token);
      return true;

    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }



}