class Bebida {
  int? id;
  String nome;
  String categoria;
  double preco;

  Bebida({
    this.id,
    required this.nome,
    required this.categoria,
    required this.preco,
  });

  factory Bebida.fromJson(Map<String, dynamic> json) => Bebida(
    id: json['id'] as int?,
    nome: json['nome'] as String? ?? '',
    categoria: json['categoria'] as String? ?? '',
    preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'nome': nome,
    'categoria': categoria,
    'preco': preco,
  };

  @override
  String toString() {
    return 'Bebida(id: $id, nome: $nome, categoria: $categoria, preco: $preco)';
  }
}
