import 'package:flutter/material.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProdutoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final produto = Provider.of<Produto>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            produto.imagemUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.produtoDetail,
              arguments: produto,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(produto.titulo),
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {
              produto.toggleFavorito();
            },
            icon: Icon(
                produto.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}