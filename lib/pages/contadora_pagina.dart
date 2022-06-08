import 'package:flutter/material.dart';
import 'package:loja/providers/counter.dart';

class ContadoraPagina extends StatefulWidget {
  const ContadoraPagina({Key? key}) : super(key: key);

  @override
  State<ContadoraPagina> createState() => _ContadoraPaginaState();
}

class _ContadoraPaginaState extends State<ContadoraPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Contador'),
      ),
      body: Column(
        children: [
          Text(CounterProvider.of(context)?.state.valor.toString() ?? '0'),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.incremento();
              });
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.decremento();
              });
            },
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
