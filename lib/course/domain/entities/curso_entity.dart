class CursoEntity {
  final int? id;
  final String descricao;
  final String ementa;

  CursoEntity({
    this.id,
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

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'descricao': descricao,
        'ementa': ementa,
      };
}
