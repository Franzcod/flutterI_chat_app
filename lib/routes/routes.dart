

import 'package:chat_110920/pages/chat_page.dart';
import 'package:chat_110920/pages/loading_page.dart';
import 'package:chat_110920/pages/login_page.dart';
import 'package:chat_110920/pages/register_page.dart';
import 'package:chat_110920/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios' : (_) => UsuariosPage(),
  'chat'     : (_) => ChatPage(),
  'login'    : (_) => LoginPage(),
  'register' : (_) => RegisterPage(),
  'loading'  : (_) => LoadingPage(),


};