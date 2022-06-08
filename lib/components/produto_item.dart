import 'package:flutter/material.dart';
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProdutoItem extends StatelessWidget {
  const ProdutoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produto = Provider.of<Produto>(context, listen: false);
    final cart = Provider.of<Carrinho>(context);

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
          title: Text(produto.nome!),
          backgroundColor: Colors.black54,
          leading: Consumer<Produto>(
            builder: (context, produto, _) => IconButton(
              onPressed: () {
                produto.toggleFavorito();
              },
              icon: Icon(
                  produto.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(produto);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
