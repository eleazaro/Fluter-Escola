import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';

class GetMatriculaAlunoService {
  final IMatriculaRepository _repository;

  GetMatriculaAlunoService(this._repository);

  Future<Either<CoreFailure, List<AlunoEntity>>> call(
          {required int idCurso}) async =>
      await _repository.getMatriculaAluno(idCurso: idCurso);
}
