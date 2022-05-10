import 'package:flutter/cupertino.dart';
import 'package:loja/data/dummy_data.dart';
import 'package:loja/models/produto.dart';

class ProdutoLista with ChangeNotifier {
  final List<Produto> _itens = dummyProdutos;

  List<Produto> get itens => [..._itens];

  void addProduto(Produto produto) {
    _itens.add(produto);
    notifyListeners();
  }
}
