import 'package:flutter/foundation.dart';
import 'dart:convert';

class Promocao {
  final int id;
  final String produto;
  final int categoria;
  final String fotoPromocao;
  final String dataIni;
  final String dataFim;
  final bool ativa;

  Promocao({
    required this.id,
    required this.produto,
    required this.categoria,
    required this.fotoPromocao,
    required this.dataIni,
    required this.dataFim,
    required this.ativa,
    
  });

  factory Promocao.fromJson(Map<String, dynamic> json) {
    bool ativaConvertido = true;
    if(json['ativa']=="true"){ativaConvertido = true;}else{ativaConvertido = false;}
    return Promocao(
      id: int.parse(json['id']),
      produto: json['produto'] as String,
      categoria: int.parse(json['categoria']),
      fotoPromocao: json['fotoPromocao'] as String,
      dataIni: json['dataIni'] as String,
      dataFim: json['dataFim'] as String,
      ativa: ativaConvertido,
    );
  }
}