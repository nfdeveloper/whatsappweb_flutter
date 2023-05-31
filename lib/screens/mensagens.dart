import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watsappweb/components/lista_mensagens.dart';
import 'package:watsappweb/models/usuario.dart';
import 'package:watsappweb/utils/paleta_cores.dart';

class Mensagens extends StatefulWidget {

  final Usuario usuarioDestinatario;

  const Mensagens(
      this.usuarioDestinatario,
      {Key? key}
      ) : super(key: key);

  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  late Usuario _usuarioestinatario;

  _recuperarDadosIniciais(){
    _usuarioestinatario = widget.usuarioDestinatario;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletaCores.corPrimaria,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                 _usuarioestinatario.urlImagem
              ),
            ),
            SizedBox(width: 8,),
            Text(
              _usuarioestinatario.nome,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert)
          )
        ],
      ),
      body: SafeArea(
        child: ListaMensagens(),
      ),
    );
  }
}
