import 'package:flutter/foundation.dart';
import 'dart:convert';

class User {
  final int ?id;
  final String email;
  final String senha;
  final String nome;

  User({
    required this.id,
    required this.email,
    required this.senha,
    required this.nome,
    
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      email: json['email'] as String,
      senha: json['senha'] as String,
      nome: json['nome'] as String,
    );
  }
}