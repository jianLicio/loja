import 'package:flutter/material.dart';
import 'package:loja/components/app_drawer.dart';
import 'package:loja/components/pedido.dart';
import 'package:loja/models/pedido_lista.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:provider/provider.dart';

class PedidoPagina extends StatelessWidget {
  Future<void> _refreshProdutos(BuildContext context) {
    return Provider.of<ProdutoLista>(
      context,
      listen: false,
    ).loadProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<PedidoLista>(
          context,
          listen: false,
        ).loadPedidos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<PedidoLista>(
              builder: (context, pedidos, child) => ListView.builder(
                itemCount: pedidos.qtdItens,
                itemBuilder: (context, i) => PedidoWidget(
                  pedido: pedidos.itens[i],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
