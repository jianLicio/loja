import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja/models/pedido.dart';

class PedidoWidget extends StatelessWidget {
  final Pedido pedido;
  const PedidoWidget({Key? key, required this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('R\$ ${pedido.total.toStringAsFixed(2)}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(pedido.data),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
