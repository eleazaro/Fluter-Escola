class CursoEntity {
  final int id;
  final String descricao;
  final String ementa;

  CursoEntity({
    required this.id,
    required this.descricao,
    required this.ementa,
  });

  factory CursoEntity.fromJson(dynamic json) {
    return CursoEntity(
      id: json['id'],
      descricao: json['descricao'],
      ementa: json['ementa'],
    );
  }
}
