class AlunoEntity {
  final int? id;
  final String nome;

  AlunoEntity({
    this.id,
    required this.nome,
  });

  factory AlunoEntity.fromJson(dynamic json) {
    return AlunoEntity(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'nome': nome,
      };
}
