import 'package:flutter/material.dart';

class PedidoPagina extends StatelessWidget {
  const PedidoPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
    );
  }
}
