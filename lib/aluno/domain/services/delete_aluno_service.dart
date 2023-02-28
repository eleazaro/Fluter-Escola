import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/aluno/domain/interfaces/ialuno_repository.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';

class DeleteAlunoService {
  final IAlunoRepository _repository;

  DeleteAlunoService(this._repository);

  Future<Either<CoreFailure, AlunoEntity>> call(
          {required AlunoEntity aluno}) async =>
      await _repository.deleteAluno(aluno: aluno);
}
