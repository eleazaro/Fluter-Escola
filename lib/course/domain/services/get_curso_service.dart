import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/icurso_repository.dart';

class GetCursoService {
  final ICursoRepository _repository;

  GetCursoService(this._repository);

  Future<Either<CoreFailure, List<CursoEntity>>> call() async =>
      await _repository.getCursos();
}
