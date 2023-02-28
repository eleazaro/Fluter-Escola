import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/aluno/domain/interfaces/ialuno_repository.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';

class GetAlunoService {
  final IAlunoRepository _repository;

  GetAlunoService(this._repository);

  Future<Either<CoreFailure, List<AlunoEntity>>> call() async =>
      await _repository.getAlunos();
}
