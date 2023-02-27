import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';

abstract class ICursoRepository {
  Future<Either<CoreFailure, List<CursoEntity>>> getCursos();
  Future<Either<CoreFailure, CursoEntity>> getCursoById({required int id});
  Future<Either<CoreFailure, CursoEntity>> postCurso(
      {required CursoEntity curso});
  Future<Either<CoreFailure, CursoEntity>> deleteCurso(
      {required CursoEntity curso});
  Future<Either<CoreFailure, CursoEntity>> putCurso(
      {required CursoEntity curso});
}
