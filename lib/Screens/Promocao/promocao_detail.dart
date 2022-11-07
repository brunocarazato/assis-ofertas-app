import 'package:flutter/material.dart';
import '../../Models/promocao_model.dart';
import '../../Services/http_service.dart';

class PromocaoDetail extends StatelessWidget {
  final Promocao promocao;
  final HttpService httpService = HttpService();
  PromocaoDetail({required this.promocao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(promocao.produto),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.delete),
        //     onPressed: () async {
        //       await httpService.deletePromocao(promocao.id);
        //       Navigator.of(context).pop();
        //     },
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text("Produto"),
                      subtitle: Text(promocao.produto),
                    ),
                    Image.network(httpService.serverURL + "/images/" + promocao.fotoPromocao),
                    ListTile(
                      title: Text("ID"),
                      subtitle: Text("${promocao.id}"),
                    ),
                    ListTile(
                      title: Text("Data Inicio"),
                      subtitle: Text(promocao.dataIni),
                    ),
                    ListTile(
                      title: Text("Data Fim"),
                      subtitle: Text(promocao.dataFim),
                      // subtitle: Text("${post.userId}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}