import 'dart:convert';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/promocao_model.dart';
import '../Models/user_model.dart';
import 'dart:io';

class HttpService {
  String loginSalvo = '';
  final String serverURL = "http://10.0.2.2:8080";


 Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory 
    print(directory.path);
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<File> writeContent(text) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(text);
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {

      return 'Error';
    }
  }
  Future login(email, senha) async {

      Response res = await post(Uri.parse(serverURL + "/login"), body: {'email': email, 'senha': senha}); 

      if (res.statusCode == 200) { 
        
        List<dynamic> body = jsonDecode(res.body)['data']; 
        print(body);
        List<User> usuario = body.map(
          (dynamic item) => User.fromJson(item),
        ).toList();
        return usuario[0];
      }else if (res.statusCode == 404 || res.statusCode == 400) { 
        return null;
      }else {
        throw "Unable to retrieve posts."; 
      }
  }

  Future signUp(User novo) async {

      Response res = await post(Uri.parse(serverURL + "/user"), body: {'email': novo.email, 'senha': novo.senha, 'nome': novo.nome}); 

      if (res.statusCode == 200) { 
        
        dynamic body = jsonDecode(res.body)['data']; 
        print(body);
        
        return body;
      }else if (res.statusCode == 400 || res.statusCode == 404) { 
        return null;
      }else {
        throw "Unable to retrieve posts."; 
      }
  }

  Future<List<Promocao>> getPromocoes() async {
    Response res = await get(Uri.parse(serverURL + "/promocao"));

    if (res.statusCode == 200) { 
      print(jsonDecode(res.body)['data']);

      List<dynamic> body = jsonDecode(res.body)['data'];

      List<Promocao> promocoes = body
        .map(
          (dynamic item) => Promocao.fromJson(item),
        )
        .toList();

      return promocoes;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<void> deletePromocao(int id) async {
    Response res = await delete(Uri.parse("$serverURL/promocao/$id"));

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Unable to delete post.";
    }
  }


}