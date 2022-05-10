class Produto {
  late final String id;
  late final String titulo;
  late final String descricao;
  late final double preco;
  late final String imagemUrl;
  bool isFavorite;

  Produto({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.isFavorite = false,
  });

  void toggleFavorito() {
    isFavorite = !isFavorite;
  }
}
