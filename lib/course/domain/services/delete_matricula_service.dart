import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';

class DeleteMatriculaService {
  final IMatriculaRepository _repository;

  DeleteMatriculaService(this._repository);

  Future<Either<CoreFailure, MatriculaEntity>> call(
          {required MatriculaEntity matricula}) async =>
      await _repository.delete(matricula: matricula);
}
