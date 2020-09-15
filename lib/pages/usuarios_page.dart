import 'package:chat_110920/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1' , nombre: 'Maria', email: 'test1@test.com' , online: true),
    Usuario(uid: '2' , nombre: 'Diego', email: 'test2@test.com' , online: false),
    Usuario(uid: '3' , nombre: 'Chuly', email: 'test3@test.com' , online: true),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text('Mi Nombre',style: TextStyle(color: Colors.black54),)),
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.exit_to_app, color: Colors.black54,),
        onPressed: (){},
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.check_circle, color: Colors.green),
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
      );
  }

  _cargandoUsuarios() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}