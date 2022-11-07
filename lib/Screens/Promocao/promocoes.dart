import 'package:flutter/material.dart';
import '../../Services/http_service.dart';
import '../../Models/promocao_model.dart';
import 'promocao_detail.dart';

class PromocoesPage extends StatefulWidget {
  bool primeiroLogin; //usar esse campo para exibir as boas vindas
  PromocoesPage({required this.primeiroLogin});

  @override
  _PromocoesPageState createState() => _PromocoesPageState();
}

class _PromocoesPageState extends State<PromocoesPage> {
  final HttpService httpService = HttpService();
  List<Promocao> todasPromocoes=[];
  List<Promocao> promocoes=[];

  _filtrarPorCategoria(value){
    if(value==0){
      setState(() {
        promocoes = todasPromocoes;
      });
    }else{
      setState(() {
        promocoes = todasPromocoes.where((promocao) => promocao.categoria == value).toList();
      });
    }
  }
  

@override
  initState() {
    // at the beginning, all users are shown
    httpService.getPromocoes().then((List<Promocao> temp) {
      setState(() { 
        promocoes = temp;
        todasPromocoes = promocoes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Promoções"),
      ),
      body:          
      Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Text("Categorias",
                style: TextStyle(color: Color.fromRGBO(144, 144, 144, 1)),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child:
                      ElevatedButton.icon(
                          icon: const Icon(
                            Icons.view_list,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('Todas'),
                          onPressed: () {
                            _filtrarPorCategoria(0);
                          },
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child:
                      ElevatedButton.icon(
                          icon: const Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('Supermercados'),
                          onPressed: () {
                            _filtrarPorCategoria(1);
                          },
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child:
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.dining_sharp,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        label: const Text('Restaurantes'),
                        onPressed: () {
                          _filtrarPorCategoria(2);
                        },
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child:
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.home_repair_service_sharp,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        label: const Text('Serviços'),
                        onPressed: () {
                          _filtrarPorCategoria(3);
                        },
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child:
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.local_mall_sharp,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        label: const Text('Outros'),
                        onPressed: () {
                          _filtrarPorCategoria(4);
                        },
                      ),
                  ),
                ])
              ),
              Expanded(
                child: promocoes.isNotEmpty
                    ? ListView.builder(
                        itemCount: promocoes.length,
                        itemBuilder: (context, index) => 
                        Card(
                          child: Container(
                            height:130,
                            color: Colors.white,
                            child:

                                    Row(
                                      children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Expanded(                                              
                                                child: Image.network(
                                                  httpService.serverURL + "/images/" + promocoes[index].fotoPromocao,
                                                ),
                                                flex:2,
                                            )
                                      ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: ListTile(
                                                // leading: const Icon(Icons.euro_symbol),
                                                title: new Row(children: <Widget>[new Text(promocoes[index].produto,
                                                        style: new TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 20.0),)
                                                        ],
                                                      ),
                                                subtitle: Text("% de desconto"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  // TextButton(
                                                  //   child:Text("PLAY"),
                                                  //   onPressed: ()
                                                  //   {},
                                                  // ),
                                                  // SizedBox(width: 8,),
                                                  TextButton.icon(
                                                    icon: const Icon(
                                                      Icons.remove_red_eye,
                                                      //color: Color.fromRGBO(144, 144, 144, 1),
                                                    ),
                                                    label: Text("VISUALIZAR"),
                                                    onPressed: () => Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => PromocaoDetail(
                                                          promocao: promocoes[index],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8,)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                          ),
                        )
                        )
                    : const Text(
                        'No momento, sem promoções para essa categoria',
                        style: TextStyle(fontSize: 15),
                      ),
              ),
          ],
        ),
      ),
    );
  }


}