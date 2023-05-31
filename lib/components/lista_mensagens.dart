import 'package:flutter/material.dart';
import 'package:watsappweb/utils/paleta_cores.dart';

class ListaMensagens extends StatefulWidget {
  const ListaMensagens({Key? key}) : super(key: key);

  @override
  State<ListaMensagens> createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;

    return Container(
      width: largura,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        children: [
          // Listagem de mensagens
          Expanded(
            child: Container(
              width: largura,
            ),
          ),

          // Caixa de criação de nova mensagem
          Container(
            padding: EdgeInsets.all(8),
            color: PaletaCores.corFundoBarra,
            child: Row(
              children: [

                // Caixa de texto
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insert_emoticon),
                        SizedBox(width: 4,),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Digite uma mensagem",
                              border: InputBorder.none
                            ),
                          ),
                        ),
                        Icon(Icons.attach_file),
                        Icon(Icons.camera_alt),
                      ],
                    ),
                  ),
                ),

                // Botão enviar
                FloatingActionButton(
                  backgroundColor: PaletaCores.corPrimaria,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    mini: true,
                    onPressed: (){},

                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
