class AutenticacaoException implements Exception {
  static const Map<String, String> erro = {
    'EMAIL_EXISTS': 'E-mail já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente, tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado',
    'INVALID_PASSWORD': 'Senha informada não confere',
    'USER_DISABLED': 'A conta do usuário foi desabilitada',
  };

  final String key;
  AutenticacaoException(this.key);

  @override
  String toString() {
    return erro[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
