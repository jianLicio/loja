import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja/models/pedido.dart';
import 'package:loja/models/produto.dart';

class PedidoWidget extends StatefulWidget {
  final Pedido pedido;
  const PedidoWidget({Key? key, required this.pedido}) : super(key: key);

  @override
  State<PedidoWidget> createState() => _PedidoWidgetState();
}

class _PedidoWidgetState extends State<PedidoWidget> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.pedido.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.pedido.data),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expandido = !_expandido;
                });
              },
            ),
          ),
          if (_expandido)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 4),
              height: widget.pedido.produtos.length * 25 + 10,
              child: Expanded(
                child: ListView(
                  children: widget.pedido.produtos.map((produto) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          produto.nome,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${produto.quantidade}x R\$ ${produto.preco}',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
