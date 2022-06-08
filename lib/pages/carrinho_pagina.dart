import 'package:flutter/material.dart';

class CarrinhoPagina extends StatelessWidget {
  const CarrinhoPagina({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
    );
  }
}
