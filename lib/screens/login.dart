import 'package:flutter/material.dart';
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
                                child: Image.asset(
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
                                  onPressed: (){},
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
                              onPressed: (){},
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
