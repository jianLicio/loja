import 'package:flutter/material.dart';
import 'package:loja/models/produto.dart';
import 'package:loja/models/produto_lista.dart';
import 'package:provider/provider.dart';

class ProdutoFormPagina extends StatefulWidget {
  const ProdutoFormPagina({Key? key}) : super(key: key);

  @override
  State<ProdutoFormPagina> createState() => _ProdutoFormPaginaState();
}

class _ProdutoFormPaginaState extends State<ProdutoFormPagina> {
  static const linkImagem =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg';
  final _precoFocus = FocusNode();
  final _descricaoFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController(text: linkImagem);

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _estaCarregando = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _precoFocus.dispose();
    _descricaoFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final produto = arg as Produto;
        _formData['id'] = produto.id;
        _formData['nome'] = produto.nome;
        _formData['preco'] = produto.preco;
        _formData['descricao'] = produto.descricao;
        _formData['imagemUrl'] = produto.imagemUrl;

        _imageUrlController.text = produto.imagemUrl;
      }
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _estaCarregando = true;
    });

    try {
      await Provider.of<ProdutoLista>(
        context,
        listen: false,
      ).saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (erro) {
      return await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Ocorreu um erro!',
          ),
          content: const Text(
              'Ocorreu um erro ao salvar o produto.\nContate o suporte'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        ),
      );
    } finally {
      setState(() => _estaCarregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: _estaCarregando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['nome']?.toString(),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_precoFocus);
                      },
                      onSaved: (nome) => _formData['nome'] = nome ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }

                        if (name.trim().length < 4) {
                          return 'Nome precisa no mínimo de 4 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['preco']?.toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _precoFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descricaoFocus);
                      },
                      onSaved: (preco) =>
                          _formData['preco'] = double.parse(preco ?? '0'),
                      validator: (_preco) {
                        final precoString = _preco ?? '';
                        final preco = double.tryParse(precoString) ?? -1;

                        if (preco <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['descricao']?.toString(),
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      textInputAction: TextInputAction.next,
                      focusNode: _descricaoFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (descricao) =>
                          _formData['descricao'] = descricao ?? '',
                      validator: (_descricao) {
                        final descricao = _descricao ?? '';

                        if (descricao.trim().isEmpty) {
                          return 'Descrição é obrigatória.';
                        }

                        if (descricao.trim().length < 5) {
                          return 'Descrição precisa no mínimo de 5 letras.';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imagemUrl) =>
                                _formData['imagemUrl'] = imagemUrl ?? '',
                            validator: (_imagemUrl) {
                              final imageUrl = _imagemUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informe a Url')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
