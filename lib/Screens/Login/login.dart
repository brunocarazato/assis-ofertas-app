import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Login/signup.dart';
import 'signup.dart';
import '../../Services/http_service.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../Promocao/promocoes.dart';
import '../../Models/user_model.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) {
            return const MyStatefulWidget();
          }
        ),
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

  _validarUsuario() async{
    if (_formKey.currentState!.validate()) {
      
      var usuario = await httpService.login(emailController.text, senhaController.text);

      if(usuario == null){
        _mostrarMsg(
          "Eita, algo não deu certo", 
          "Por favor, verifique seu email e/ou senha e tente novamente");
          return false;
      }
      var a = await httpService.writeContent(emailController.text + ";" + senhaController.text);
      var b = await httpService.readContent();
      // print(b);

     
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute<bool>(
          fullscreenDialog: true,
          builder: (BuildContext context) => PromocoesPage(primeiroLogin: false),
        ),
      );

      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  height: 100,
                ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'PromoClub Assis',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              // Container(
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.all(10),
              //     child: const Text(
              //       'Sign in',
              //       style: TextStyle(fontSize: 20),
              //     )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  validator: MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        EmailValidator(errorText: "Enter valid email id"),
                  ])
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Esqueci minha senha',),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Entrar'),
                    onPressed: () {
                      _validarUsuario();
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Ainda não tem uma conta?'),
                  TextButton(
                    child: const Text(
                      'Registre-se',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  const Text('É rapidinho, só queremos te conhecer :)'),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )
      )
        
    );
  }



}