import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/constantes.dart';

class Produto with ChangeNotifier {
  late final String id;
  late final String nome;
  late final String descricao;
  late final double preco;
  late final String imagemUrl;
  bool isFavorite;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.isFavorite = false,
  });

  void _toggleFavorito() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorito() async {
    try {
      _toggleFavorito();
      final response = await http.patch(
        Uri.parse('${Constantes.produtoBaseUrl}/$id.json'),
        body: jsonEncode({"isFavorite": isFavorite}),
      );

      if (response.statusCode >= 400) {}
    } catch (_) {
      _toggleFavorito();
    }
  }
}
