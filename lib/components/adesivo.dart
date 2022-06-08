import 'package:flutter/material.dart';

class Adesivo extends StatelessWidget {
  final Widget child;
  final String valor;
  final Color? cor;
  const Adesivo({Key? key, required this.child, required this.valor, this.cor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: cor ?? Theme.of(context).colorScheme.secondary,
            ),
            constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
            child: Text(
              valor,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          right: 8,
          top: 8,
        ),
      ],
    );
  }
}
