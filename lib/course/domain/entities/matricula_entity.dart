class MatriculaEntity {
  final int? id;
  final String nome;
  final int? idCurso;
  final int? idAluno;

  MatriculaEntity({
    this.id,
    required this.nome,
    this.idCurso,
    this.idAluno,
  });

  factory MatriculaEntity.fromJson(dynamic json) {
    return MatriculaEntity(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'id_aluno': idAluno,
        'id_curso': idCurso,
      };
}
