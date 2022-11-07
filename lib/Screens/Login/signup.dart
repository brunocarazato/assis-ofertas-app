import 'package:flutter/material.dart';
import '../../Services/http_service.dart';
import '../../Models/user_model.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../Promocao/promocoes.dart';
//import 'package:platform_device_id/platform_device_id.dart';

class SignupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PromoClub Assis - Cadastro"),
      ),
      body: const MyStatefulWidget(),
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}



class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final HttpService httpService = HttpService();

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfirmationController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  _mostrarMsg(titulo, texto) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title:  Text(titulo),
            content:  Text(texto),
            actions: <Widget>[
              // define os botões na base do dialogo
              TextButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }


  _logarUsuario(email, senha) async{
      
      var a = await httpService.writeContent(email + ";" + senha);
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute<bool>(
          fullscreenDialog: true,
          builder: (BuildContext context) => PromocoesPage(primeiroLogin: true),
        ),
      );

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  height: 50,
                ),

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Como você gostaria de acessar?',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome completo',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: senhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(6,
                            errorText: "Password should be atleast 6 characters"),
                        MaxLengthValidator(15,
                            errorText:
                            "Password should not be greater than 15 characters")
                  ])
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: senhaConfirmationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirme sua senha',
                  ),
                  validator: (val) => MatchValidator(
                            errorText: 
                            "As senhas digitadas não estão iguais")
                            .validateMatch(val.toString(), senhaController.text)
                ),
              ),
              Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Cadastrar'),
                    onPressed: () async{
                      // print(emailController.text);
                      // print(senhaController.text);
                      // print(senhaConfirmationController.text);
                      // print(nomeController.text);
                      User novo = User(email: emailController.text, senha: senhaController.text, nome: nomeController.text, id: null);
                      var usuario = await httpService.signUp(novo);
                      print(usuario);
                      if(usuario == null){
                        _mostrarMsg(
                          "Eita, algo não deu certo", 
                          "Por favor, verifique seu email e/ou senha e tente novamente");
                      }else{
                        _logarUsuario(emailController.text, senhaController.text);
                      }
                    },
                  )
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: 
                    const Text('Estamos muito feliz em ter você no PromoClub Assis!'),
              ),
            ],
          )
      )
    );
  }
}