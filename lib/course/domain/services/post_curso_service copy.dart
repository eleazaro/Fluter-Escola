import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';

class PostMatriculaService {
  final IMatriculaRepository _repository;

  PostMatriculaService(this._repository);

  Future<Either<CoreFailure, List<MatriculaEntity>>> call(
          {required List<MatriculaEntity> matriculas}) async =>
      await _repository.post(matriculas: matriculas);
}
