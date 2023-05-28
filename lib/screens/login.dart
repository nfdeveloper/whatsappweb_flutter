import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:watsappweb/models/usuario.dart';
import 'package:watsappweb/utils/paleta_cores.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerNome = TextEditingController(text: "Nilton Dev");
  TextEditingController _controllerEmail = TextEditingController(text: "nfdeveloper04@gmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "1234567");
  bool _cadastroUsuario = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Uint8List? _arquivoImagemSelecionado;

  _verificarUsuarioLogado() async{

    User? usuarioLogado = await _auth.currentUser;

    if( usuarioLogado != null ){
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  _selecionarImagem() async {

    // Selecionar arquivo
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    // Recuperar o arquivo
    setState(() {
      _arquivoImagemSelecionado = resultado?.files.single.bytes;
    });

  }

  _uploadImagem(Usuario usuario){

    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
    if(arquivoSelecionado != null){
      Reference imagemPerfilRef = _storage.ref("imagens/perfil/${usuario.idUsuario}.jpg");
      UploadTask uploadTask = imagemPerfilRef.putData(arquivoSelecionado);

      uploadTask.whenComplete(() async{
        String urlImagem = await uploadTask.snapshot.ref.getDownloadURL();
        usuario.urlImagem = urlImagem;

        //Salvando dados no Firebase
        final usuariosRef = _firestore.collection("usuarios");
        usuariosRef.doc(usuario.idUsuario)
        .set(usuario.toMap())
        .then((value){

          //Tela Pincipal
          Navigator.pushReplacementNamed(context, "/home");

        });

      });

    }

  }

  _validarCampos() async{

    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( email.isNotEmpty && email.contains("@") ){
      if( senha.isNotEmpty && senha.length > 6 ){

        if( _cadastroUsuario ){

          if(_arquivoImagemSelecionado != null){

            //Cadastro
            if( nome.isNotEmpty && nome.length > 3 ){

              await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: senha
              ).then((auth) {

                // => Upload da Imagem
                String? idUsuario = auth.user?.uid;
                if(idUsuario != null){

                  Usuario usuario = Usuario(
                      idUsuario,
                      nome,
                      email
                  );

                  _uploadImagem(usuario);
                }
              });

            }else{
              print("Nome inválido, digite ao menos 3 caracteres");
            }

          }else{
            print("Selecione uma imagem");
          }

        }else{

          // Login
          await _auth.signInWithEmailAndPassword(
              email: email,
              password: senha
          ).then((auth){

            //Tela Pincipal
            Navigator.pushReplacementNamed(context, "/home");

          });
        }

      }else{
        print("Senha inválida");
      }

    }else{
      print("Email inválido");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Antes de carregar a aplicação verificando se o Usuario está logado
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {

    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        width: larguraTela,
        height: alturaTela,
        child: Stack(
          children: [

            Positioned(
              child: Container(
                width: larguraTela,
                height: alturaTela * 0.5,
                color: PaletaCores.corPrimaria,
              ),
            ),

            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    child: Container(
                      width: 500,
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [

                          // => Imagem Perfil
                          Visibility(
                            visible: _cadastroUsuario,
                              child: ClipOval(
                                child: _arquivoImagemSelecionado != null
                                    ? Image.memory(
                                        _arquivoImagemSelecionado!,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover
                                    )
                                    : Image.asset(
                                          "images/perfil.png",
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover
                                      ),
                              ),
                          ),

                          SizedBox(height: 8,),

                          Visibility(
                            visible: _cadastroUsuario,
                              child: OutlinedButton(
                                  onPressed: _selecionarImagem,
                                  child: Text("Selecionar foto")
                              ),
                          ),

                          SizedBox(height: 8,),

                          // => Caixa de Texto Nome
                          Visibility(
                            visible: _cadastroUsuario,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: _controllerNome,
                              decoration: InputDecoration(
                                  hintText: "Nome",
                                  labelText: "Nome",
                                  suffixIcon: Icon(
                                      Icons.person_outline
                                  )
                              ),
                            ),
                          ),

                          // => Caixa de Texto Email
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Email",
                              suffixIcon: Icon(
                                Icons.mail_outline
                              )
                            ),
                          ),

                          //Caixa de Texto Senha
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: _controllerSenha,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Senha",
                                labelText: "Senha",
                                suffixIcon: Icon(
                                    Icons.lock_outline
                                )
                            ),
                          ),

                          SizedBox(height: 20,),

                          // Botão
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                _validarCampos();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: PaletaCores.corPrimaria
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                    _cadastroUsuario ? "Cadastro":"Login",
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            )
                          ),

                          Row(
                            children: [
                              Text("Login"),
                              Switch(
                                  value: _cadastroUsuario,
                                  onChanged: (bool valor){
                                    setState(() {
                                      _cadastroUsuario = valor;
                                    });
                                  }
                              ),
                              Text("Cadastro"),
                            ],
                          )

                        ],
                      ),
                    )
                  )
                ),
              )
            )

          ],
        ),
      ),
    );
  }
}
