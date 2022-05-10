import 'package:flutter/material.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/utils/app_routes.dart';

class ProdutoItem extends StatelessWidget {
  final Produto produto;
  const ProdutoItem({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(Icons.favorite),
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
