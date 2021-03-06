import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/produto.dart';
import '../models/produto_lista.dart';
import 'produto_grid_item.dart';

class ProdutoGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProdutoGrid({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoLista>(context);
    final List<Produto> loadedProducts =
        showFavoriteOnly ? provider.itensFavoritos : provider.itens;
    return GridView.builder(
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProdutoGridItem(),
      ),
    );
  }
}
