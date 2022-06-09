import 'package:flutter/material.dart';

import '../models/produto.dart';

class ProdutoDetalhePagina extends StatelessWidget {
  const ProdutoDetalhePagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produto produto =
        ModalRoute.of(context)!.settings.arguments as Produto;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome!),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              produto.imagemUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'R\$ ${produto.preco}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              produto.descricao,
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
