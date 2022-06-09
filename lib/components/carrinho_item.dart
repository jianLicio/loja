import 'package:flutter/material.dart';
import 'package:loja/models/item_carrinho.dart';

class CarrinhoItemWidget extends StatelessWidget {
  final ItemCarrinho carrinhoItem;

  const CarrinhoItemWidget({Key? key, required this.carrinhoItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
        subtitle:
            Text('total:R\$ ${carrinhoItem.preco * carrinhoItem.quantidade}'),
        trailing: Text('${carrinhoItem.quantidade}x'),
      ),
    );
  }
}
