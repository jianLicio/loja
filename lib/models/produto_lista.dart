import 'package:flutter/cupertino.dart';
import 'package:loja/data/dummy_data.dart';
import 'package:loja/models/produto.dart';

class ProdutoLista with ChangeNotifier {
  final List<Produto> _itens = dummyProdutos;

  List<Produto> get itens => [..._itens];
  List<Produto> get itensFavoritos =>
      _itens.where((prod) => prod.isFavorite).toList();

  void addProduto(Produto produto) {
    _itens.add(produto);
    notifyListeners();
  }

  // bool _showFavoriteOnly = false;

  // List<Produto> get itens {
  //   if (_showFavoriteOnly) {
  //     return _itens.where((prod) => prod.isFavorite).toList();
  //   }
  //   return [..._itens];
  // }

  // List<Produto> get favoriteItems =>
  //     _itens.where((prod) => prod.isFavorite).toList();

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  // void addProduto(Produto produto) {
  //   _itens.add(produto);
  //   notifyListeners();
  // }
}
