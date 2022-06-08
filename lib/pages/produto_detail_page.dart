import 'package:flutter/material.dart';

import '../models/produto.dart';

class ProdutoDetailPage extends StatelessWidget {
  const ProdutoDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produto produto =
        ModalRoute.of(context)!.settings.arguments as Produto;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome!),
      ),
    );
  }
}
