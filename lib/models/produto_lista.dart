import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:loja/data/dummy_data.dart';
import 'package:loja/models/produto.dart';

class ProdutoLista with ChangeNotifier {
  final List<Produto> _itens = dummyProdutos;
  final _baseUrl = 'https://loja-jian-default-rtdb.firebaseio.com';

  List<Produto> get itens => [..._itens];
  List<Produto> get itensFavoritos =>
      _itens.where((prod) => prod.isFavorite).toList();

  int get itensContador {
    return _itens.length;
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final produto = Produto(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['nome'].toString(),
      descricao: data['descricao'] as String,
      preco: data['preco'] as double,
      imagemUrl: data['imagemUrl'] as String,
    );

    if (hasId) {
      return atualizarProduto(produto);
    } else {
      return addProduto(produto);
    }
  }

  Future<void> addProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/produtos.json'),
      body: jsonEncode({
        "nome": produto.nome,
        "descricao": produto.descricao,
        "preco": produto.preco,
        "imagemUrl": produto.imagemUrl,
        "isFavorite": produto.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    print(id);
    _itens.add(
      Produto(
        id: id,
        nome: produto.nome,
        descricao: produto.descricao,
        preco: produto.preco,
        imagemUrl: produto.imagemUrl,
        isFavorite: produto.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> atualizarProduto(Produto produto) {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      _itens[index] = produto;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Produto produto) {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      _itens.removeWhere((p) => p.id == produto.id);
      notifyListeners();
    }
  }
}
