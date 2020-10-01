
import 'package:chat_110920/services/chat_service.dart';
import 'package:chat_110920/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_110920/models/usuario.dart';
import 'package:chat_110920/services/auth_service.dart';
import 'package:chat_110920/services/socket_service.dart';



class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

  // final usuarios = [
  //   Usuario(uid: '1' , nombre: 'Maria', email: 'test1@test.com' , online: true),
  //   Usuario(uid: '2' , nombre: 'Diego', email: 'test2@test.com' , online: false),
  //   Usuario(uid: '3' , nombre: 'Chuly', email: 'test3@test.com' , online: true),
    
  // ];

  @override
  void initState() { 
    this._cargandoUsuarios();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    
    final usuarios = authService.usuario;

    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text(usuarios.nombre  ,style: TextStyle(color: Colors.black54),)),
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.exit_to_app, color: Colors.black54,),
        onPressed: (){

          //Desconectarnos del server
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              
              title: Center(child: Text('¿Estas Seguro?', style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold))),
              content: Text('Vas a desconectarte', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Cancelar', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold,),),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: Text('Salir', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold,),),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                    
                    socketService.disconnect();
                    AuthService.deleteToken();
                  },
                ),
              ],
            ),
          );



        },
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: (socketService.serverStatus == ServerStatus.Online)
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.offline_bolt,color: Colors.red),
        )
      ],
    ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargandoUsuarios,
        header: ClassicHeader(
          completeIcon: Icon(Icons.check, color: Colors.blue[200] ),
          refreshingText: 'Actualizando',
          completeText: 'Estamos Ready',
          // waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
      ),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_ , i) => Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[200],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          final chatService  = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuario;

          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargandoUsuarios() async{


      this.usuarios= await usuarioService.getUsuarios();
      setState(() {});



    // // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}