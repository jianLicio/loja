import 'package:flutter/material.dart';
import 'package:loja/exceptions/http_exceptions.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class ProdutoItem extends StatelessWidget {
  final Produto produto;
  const ProdutoItem(
    this.produto, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imagemUrl),
      ),
      title: Text(produto.nome!),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(255, 255, 118, 163),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.produtosForm,
                  arguments: produto,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir Produto'),
                    content: const Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<ProdutoLista>(
                            context,
                            listen: false,
                          ).removeProduct(produto);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Não'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  try {
                    if (value ?? false) {
                      await Provider.of<ProdutoLista>(
                        context,
                        listen: false,
                      ).removeProduct(produto);
                    }
                  } on HttpException catch (erro) {
                    debugPrint('erro $erro');
                    msg.showSnackBar(
                      SnackBar(
                        content: Text(erro.toString()),
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
