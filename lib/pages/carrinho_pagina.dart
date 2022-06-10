import 'package:flutter/material.dart';
import 'package:loja/components/carrinho_item.dart';
import 'package:loja/models/carrinho.dart';
import 'package:loja/models/pedido_lista.dart';
import 'package:provider/provider.dart';

class CarrinhoPagina extends StatelessWidget {
  const CarrinhoPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Carrinho carrinho = Provider.of(context);
    final itens = carrinho.itens.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    'R\$ ${carrinho.totalCompras.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<PedidoLista>(context, listen: false)
                        .addPedido(carrinho);
                    carrinho.clear();
                  },
                  child: const Text('Comprar'),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, i) =>
                CarrinhoItemWidget(carrinhoItem: itens[i]),
          ),
        ),
      ]),
    );
  }
}
