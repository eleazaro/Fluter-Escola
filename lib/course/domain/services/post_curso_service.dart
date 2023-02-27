import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/icurso_repository.dart';

class PostCursoService {
  final ICursoRepository _repository;

  PostCursoService(this._repository);

  Future<Either<CoreFailure, CursoEntity>> call(
          {required CursoEntity curso}) async =>
      await _repository.postCurso(curso: curso);
}
