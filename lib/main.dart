import 'package:flutter/material.dart';
import 'Screens/Promocao/promocoes.dart';
import 'Screens/Login/login.dart';
import 'Services/http_service.dart';

void main() {
  runApp(MyApp());
}
  Future<bool>_checarLoginSalvo() async {  
    final HttpService httpService = HttpService();
    var data = await httpService.readContent();
    if (data == "Error" || data.isEmpty){
      return false;
    }
    //existe um usuario, vamos validar
    var login = data.split(";");
    print(login);
    if (data == "Error" || data.isEmpty || login.isEmpty){
      return false;
    } 
    var usuario = await httpService.login(login[0], login[1]);
    if(usuario == null){
      await httpService.writeContent("");
      return false;
    }
    return true;
  }

class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context){
        return MaterialApp(
          title: 'Test App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
                  future: _checarLoginSalvo(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                      if (snapshot.data == true ){
                          return PromocoesPage(primeiroLogin: false);
                      }
                        /// other way there is no user logged.
                        return LoginPage();
                  }
                )
        );
      }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'PromoClub Assis',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: LoginPage(),
  //   );
  // }
}