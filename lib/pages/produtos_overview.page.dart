import 'package:flutter/material.dart';

import '../components/product_grid.dart';

class ProdutosOverviewPage extends StatelessWidget {
  const ProdutosOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Loja')),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ProdutoGrid(),
      ),
    );
  }
}
