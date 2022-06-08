import 'package:flutter/cupertino.dart';

class Produto with ChangeNotifier {
  late final String id;
  final String? nome;
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

  void toggleFavorito() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
