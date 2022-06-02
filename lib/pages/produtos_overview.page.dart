import 'package:flutter/material.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:provider/provider.dart';

import '../components/product_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProdutosOverviewPage extends StatefulWidget {
  const ProdutosOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProdutosOverviewPage> createState() => _ProdutosOverviewPageState();
}

class _ProdutosOverviewPageState extends State<ProdutosOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoLista>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProdutoGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
