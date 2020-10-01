import 'package:chat_110920/global/environment.dart';
import 'package:chat_110920/models/usuarios_response.dart';
import 'package:chat_110920/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_110920/models/usuario.dart';


class  UsuariosService {

  Future<List<Usuario>> getUsuarios() async{
    try{

      final resp = await http.get('${Environment.apiUrl}/usuarios',
        headers: {
          'Content-type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usuariosResponse =  usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;

    }catch(e){
      return [];
    }
  }

}