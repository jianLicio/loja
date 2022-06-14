import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:loja/data/dummy_data.dart';
import 'package:loja/models/produto.dart';

class ProdutoLista with ChangeNotifier {
  final List<Produto> _itens = dummyProdutos;

  List<Produto> get itens => [..._itens];
  List<Produto> get itensFavoritos =>
      _itens.where((prod) => prod.isFavorite).toList();

  int get itensContador {
    return _itens.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final produto = Produto(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['nome'].toString(),
      descricao: data['descricao'] as String,
      preco: data['preco'] as double,
      imagemUrl: data['imagemUrl'] as String,
    );

    if (hasId) {
      atualizarProduto(produto);
    } else {
      addProduto(produto);
    }
  }

  void addProduto(Produto produto) {
    _itens.add(produto);
    notifyListeners();
  }

  void atualizarProduto(Produto produto) {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      _itens[index] = produto;
      notifyListeners();
    }
  }

  void removeProduct(Produto produto) {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      _itens.removeWhere((p) => p.id == produto.id);
      notifyListeners();
    }
  }
}
