import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja/exceptions/autenticacao_exception.dart';

class Autenticacao with ChangeNotifier {
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyB9OckmZSrEtGDn8ApxJXRsP6Rp8p7HxlQ';

  Future<void> _autenticacao(
      String email, String senha, String urlFragmento) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragmento?key=AIzaSyB9OckmZSrEtGDn8ApxJXRsP6Rp8p7HxlQ';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': senha,
        'returnSecureToken': true,
      }),
    );
    final corpo = jsonDecode(response.body);

    debugPrint('_autenticação: $corpo');

    if (corpo['error'] != null) {
      throw AutenticacaoException(corpo['error']['message']);
    }

    debugPrint('_autenticação: $corpo');
  }

  Future<void> cadastro(String email, String senha) async {
    return _autenticacao(email, senha, 'signUp');
  }

  Future<void> login(String email, String senha) async {
    return _autenticacao(email, senha, 'signInWithPassword');
  }
}
