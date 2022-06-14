import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/pedido.dart';

class PedidoLista with ChangeNotifier {
  final List<Pedido> _itens = [];

  List<Pedido> get itens {
    return [..._itens];
  }

  int get qtdItens {
    return _itens.length;
  }

  void addPedido(Carrinho carrinho) {
    _itens.insert(
      0,
      Pedido(
        id: Random().nextDouble().toString(),
        total: carrinho.totalCompras,
        data: DateTime.now(),
        produtos: carrinho.itens.values.toList(),
      ),
    );

    notifyListeners();
  }
}
