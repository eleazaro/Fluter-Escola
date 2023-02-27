import 'package:dartz/dartz.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';

class GetMatriculaCursoService {
  final IMatriculaRepository _repository;

  GetMatriculaCursoService(this._repository);

  Future<Either<CoreFailure, List<MatriculaEntity>>> call(
          {required int idCurso}) async =>
      await _repository.getMatriculaByIdCurso(idCurso: idCurso);
}
