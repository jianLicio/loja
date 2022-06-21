import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/item_carrinho.dart';
import 'package:loja/models/pedido.dart';

import '../utils/constantes.dart';

class PedidoLista with ChangeNotifier {
  final List<Pedido> _itens = [];

  List<Pedido> get itens {
    return [..._itens];
  }

  int get qtdItens {
    return _itens.length;
  }

  Future<void> addPedido(Carrinho carrinho) async {
    final data = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constantes.pedidoBaseUrl}.json'),
      body: jsonEncode(
        {
          "total": carrinho.totalCompras,
          "data": data.toIso8601String(),
          "produtos": carrinho.itens.values
              .map(
                (carrinhoItem) => {
                  'id': carrinhoItem.id,
                  'produtoId': carrinhoItem.produtoId,
                  'nome': carrinhoItem.nome,
                  'quantidade': carrinhoItem.quantidade,
                  'preco': carrinhoItem.preco,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];

    _itens.insert(
      0,
      Pedido(
        id: id,
        total: carrinho.totalCompras,
        data: data,
        produtos: carrinho.itens.values.toList(),
      ),
    );

    notifyListeners();
  }

  Future<void> loadPedidos() async {
    _itens.clear();
    final resposta = await http.get(
      Uri.parse('${Constantes.pedidoBaseUrl}.json'),
    );

    if (resposta.body == 'null') return;

    Map<String, dynamic> dados = jsonDecode(resposta.body);
    dados.forEach((pedidoId, pedidoDados) {
      _itens.add(
        Pedido(
          id: pedidoId,
          total: pedidoDados['total'],
          data: DateTime.parse(pedidoDados['data']),
          produtos: (pedidoDados['produtos'] as List<dynamic>).map((item) {
            return ItemCarrinho(
              id: item['id'],
              produtoId: item['produtoId'],
              nome: item['nome'],
              quantidade: item['quantidade'],
              preco: item['preco'],
            );
          }).toList(),
        ),
      );
    });
    debugPrint('$dados');
    notifyListeners();
  }
}
