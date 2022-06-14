import 'package:flutter/material.dart';
import 'package:loja/models/item_carrinho.dart';
import 'package:provider/provider.dart';

import '../models/carrinho.dart';

class CarrinhoItemWidget extends StatelessWidget {
  final ItemCarrinho carrinhoItem;

  const CarrinhoItemWidget({Key? key, required this.carrinhoItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(carrinhoItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem certeza?'),
            content: const Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Sim'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Não'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Carrinho>(context, listen: false)
            .removeItem(carrinhoItem.produtoId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Expanded(
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(
                  child: Text('${carrinhoItem.preco}'),
                ),
              ),
            ),
            title: Text(carrinhoItem.nome),
            subtitle: Text(
                'total:R\$ ${carrinhoItem.preco * carrinhoItem.quantidade}'),
            trailing: Text('${carrinhoItem.quantidade}x'),
          ),
        ),
      ),
    );
  }
}
