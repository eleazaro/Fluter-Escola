import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/entities/aluno_entity.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';

abstract class IMatriculaRepository {
  Future<Either<CoreFailure, List<MatriculaEntity>>> getMatriculaByIdCurso(
      {required int idCurso});
  Future<Either<CoreFailure, List<AlunoEntity>>> getMatriculaAluno(
      {required int idCurso});
}
