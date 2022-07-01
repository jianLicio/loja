import 'package:flutter/material.dart';
import 'package:loja/exceptions/autenticacao_exception.dart';
import 'package:loja/models/autenticacao.dart';
import 'package:provider/provider.dart';

enum modoDeAutenticacao { cadastro, login }

class AutenticacaoForm extends StatefulWidget {
  const AutenticacaoForm({Key? key}) : super(key: key);

  @override
  State<AutenticacaoForm> createState() => _AutenticacaoFormState();
}

class _AutenticacaoFormState extends State<AutenticacaoForm> {
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  modoDeAutenticacao _modoDeAutenticacao = modoDeAutenticacao.login;
  final Map<String, String> _autenticarDados = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _modoDeAutenticacao == modoDeAutenticacao.login;
  bool _isSignup() => _modoDeAutenticacao == modoDeAutenticacao.cadastro;

  void _escolherModoDeAutenticacao() {
    setState(() {
      if (_isLogin()) {
        _modoDeAutenticacao = modoDeAutenticacao.cadastro;
      } else {
        _modoDeAutenticacao = modoDeAutenticacao.login;
      }
    });
  }

  void _mostrarErroDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submeter() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);
    _formKey.currentState?.save;

    Autenticacao autenticacao = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await autenticacao.login(
          _autenticarDados['email']!,
          _autenticarDados['password']!,
        );
      } else {
        await autenticacao.cadastro(
          _autenticarDados['email']!,
          _autenticarDados['password']!,
        );
      }
    } on AutenticacaoException catch (erro) {
      _mostrarErroDialog(erro.toString());
    } catch (erro) {
      _mostrarErroDialog('ocorreu  um erro, contate o suporte: $erro');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 350,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _autenticarDados['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    debugPrint('Informar um email válido');
                    return 'Informar um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (senha) => _autenticarDados['password'] = senha ?? '',
                controller: _senhaController,
                validator: (_senha) {
                  final senha = _senha ?? '';
                  if (senha.isEmpty || senha.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              if (_isSignup())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _isLogin()
                      ? null
                      : (_senha) {
                          final senha = _senha ?? '';
                          if (senha != _senhaController.text) {
                            return 'Senhas Informadas não conferem';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submeter,
                  child: Text(
                    _isLogin() ? 'ENTRAR' : 'CADASTRAR',
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: _escolherModoDeAutenticacao,
                child: Text(
                  _isLogin() ? 'DESEJA REJISTRAR?' : 'JÁ POSSUI CONTA?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
