import 'package:flutter/material.dart';

enum modoDeAutenticacao { cadastro, login }

class AutenticacaoForm extends StatefulWidget {
  const AutenticacaoForm({Key? key}) : super(key: key);

  @override
  State<AutenticacaoForm> createState() => _AutenticacaoFormState();
}

class _AutenticacaoFormState extends State<AutenticacaoForm> {
  final _senhaController = TextEditingController();
  final modoDeAutenticacao _modoDeAutenticacao = modoDeAutenticacao.login;
  final Map<String, String> _autenticarDados = {
    'email': '',
    'senha': '',
  };
  void _submeter() {}
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _autenticarDados['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informar um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (senha) => _autenticarDados['senha'] = senha ?? '',
                controller: _senhaController,
                validator: (_senha) {
                  final senha = _senha ?? '';
                  if (senha.isEmpty || senha.length < 5) {
                    return 'Informe uma senha válida';
                  }
                },
              ),
              if (_modoDeAutenticacao == modoDeAutenticacao.cadastro)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _modoDeAutenticacao == modoDeAutenticacao.login
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
              ElevatedButton(
                onPressed: _submeter,
                child: Text(
                  _modoDeAutenticacao == modoDeAutenticacao.login
                      ? 'ENTRAR'
                      : 'CADASTRAR',
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
            ],
          ),
        ),
      ),
    );
  }
}
