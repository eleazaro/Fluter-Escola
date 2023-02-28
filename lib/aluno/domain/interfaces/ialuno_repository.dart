import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';

abstract class IAlunoRepository {
  Future<Either<CoreFailure, List<AlunoEntity>>> getAlunos();
  Future<Either<CoreFailure, AlunoEntity>> getAlunoById({required int id});
  Future<Either<CoreFailure, AlunoEntity>> postAluno(
      {required AlunoEntity aluno});
  Future<Either<CoreFailure, AlunoEntity>> deleteAluno(
      {required AlunoEntity aluno});
  Future<Either<CoreFailure, AlunoEntity>> putAluno(
      {required AlunoEntity aluno});
}
