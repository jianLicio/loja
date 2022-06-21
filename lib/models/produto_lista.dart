import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:loja/exceptions/http_exceptions.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/utils/constantes.dart';

class ProdutoLista with ChangeNotifier {
  final List<Produto> _itens = [];

  List<Produto> get itens => [..._itens];
  List<Produto> get itensFavoritos =>
      _itens.where((prod) => prod.isFavorite).toList();

  Future<void> loadProdutos() async {
    _itens.clear();
    final resposta = await http.get(
      Uri.parse('${Constantes.produtoBaseUrl}.json'),
    );

    if (resposta.body == 'null') return;

    Map<String, dynamic> dados = jsonDecode(resposta.body);
    dados.forEach((produtoId, produtoDados) {
      _itens.add(
        Produto(
          id: produtoId,
          nome: produtoDados['nome'],
          descricao: produtoDados['descricao'],
          preco: produtoDados['preco'],
          imagemUrl: produtoDados['imagemUrl'],
          isFavorite: produtoDados['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

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
      Uri.parse('${Constantes.produtoBaseUrl}.json'),
      body: jsonEncode({
        "nome": produto.nome,
        "descricao": produto.descricao,
        "preco": produto.preco,
        "imagemUrl": produto.imagemUrl,
        "isFavorite": produto.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    debugPrint(id);
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

  Future<void> atualizarProduto(Produto produto) async {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constantes.produtoBaseUrl}/${produto.id}.json'),
        body: jsonEncode({
          "nome": produto.nome,
          "descricao": produto.descricao,
          "preco": produto.preco,
          "imagemUrl": produto.imagemUrl,
        }),
      );
      _itens[index] = produto;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Produto produto) async {
    int index = _itens.indexWhere((p) => p.id == produto.id);

    if (index >= 0) {
      final produto = _itens[index];
      _itens.removeWhere((p) => p.id == produto.id);
      notifyListeners();

      final resposta = await http
          .delete(Uri.parse('${Constantes.produtoBaseUrl}/${produto.id}.json'));

      if (resposta.statusCode >= 400) {
        _itens.insert(index, produto);
        notifyListeners();
        throw HttpException(
          msg: 'erro ao remover o produto',
          statusCode: resposta.statusCode,
        );
      }
    }
  }
}
