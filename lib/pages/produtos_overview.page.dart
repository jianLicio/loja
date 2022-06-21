import 'package:flutter/material.dart';
import 'package:loja/components/adesivo.dart';
import 'package:loja/components/app_drawer.dart';
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:loja/utils/app_routes.dart';
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
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProdutoLista>(context, listen: false)
        .loadProdutos()
        .then((value) => setState((() => _isloading = false)));
  }

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
          Consumer<Carrinho>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.carrinho);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) =>
                Adesivo(valor: cart.itemsCount.toString(), child: child!),
          )
        ],
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProdutoGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
