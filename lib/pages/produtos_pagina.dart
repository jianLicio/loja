import 'package:flutter/material.dart';
import 'package:loja/components/app_drawer.dart';
import 'package:loja/components/produto_item.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:loja/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProdutosPagina extends StatelessWidget {
  const ProdutosPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProdutoLista produtos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.produtosForm);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: produtos.itensContador,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProdutoItem(produtos.itens[i]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
