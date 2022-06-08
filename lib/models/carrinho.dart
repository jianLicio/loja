import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja/models/produto.dart';

import 'item_carrinho.dart';

class Carrinho with ChangeNotifier {
  Map<String, ItemCarrinho> _itens = {};

  Map<String, ItemCarrinho> get itens {
    return {..._itens};
  }

  int get itemsCount {
    return _itens.length;
  }

  double get totalAmount {
    double total = 0.0;
    _itens.forEach((key, cartItem) {
      total += cartItem.preco * cartItem.quantidade;
    });
    return total;
  }

  void addItem(Produto produto) {
    if (_itens.containsKey(produto.id)) {
      _itens.update(
        produto.id,
        (existeItem) => ItemCarrinho(
          id: existeItem.id,
          produtoId: existeItem.produtoId,
          nome: existeItem.nome,
          quantidade: existeItem.quantidade + 1,
          preco: existeItem.preco,
        ),
      );
    } else {
      _itens.putIfAbsent(
        produto.id,
        () => ItemCarrinho(
          id: Random().nextDouble().toString(),
          produtoId: produto.id,
          nome: produto.nome!,
          quantidade: 1,
          preco: produto.preco,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _itens.remove(productId);
    notifyListeners();
  }

  void clear() {
    _itens = {};
    notifyListeners();
  }
}
