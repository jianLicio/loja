import 'package:flutter/material.dart';
import 'package:loja/components/app_drawer.dart';
import 'package:loja/components/pedido.dart';
import 'package:loja/models/pedido_lista.dart';
import 'package:provider/provider.dart';

class PedidoPagina extends StatelessWidget {
  const PedidoPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PedidoLista pedidos = Provider.of(context);
    print('quantidade de intens: ${pedidos.qtdItens}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: pedidos.qtdItens,
        itemBuilder: (context, i) => PedidoWidget(
          pedido: pedidos.itens[i],
        ),
      ),
    );
  }
}
