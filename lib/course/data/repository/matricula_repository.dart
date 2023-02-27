import 'dart:convert';

import 'package:flutter_escola/aluno/entities/aluno_entity.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';
import 'package:flutter_escola/course/error_handling/exceptions.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MatriculaRepository implements IMatriculaRepository {
  @override
  Future<Either<CoreFailure, List<MatriculaEntity>>> getMatriculaByIdCurso(
      {required int idCurso}) async {
    final List<MatriculaEntity> matriculas = [];
    var url = Uri.http('10.0.2.2:3000', '/matricula/curso/$idCurso');

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        return throw GetMatriculaCursoException(StackTrace.current,
            'GetMatriculaCurso', "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      for (var matricula in data) {
        matriculas.add(MatriculaEntity.fromJson(matricula));
      }

      return Right(matriculas);
    } catch (exception, stacktrace) {
      return Left(throw GetMatriculaCursoException(
          stacktrace, 'GetMatriculaCurso', exception));
    }
  }

  @override
  Future<Either<CoreFailure, List<AlunoEntity>>> getMatriculaAluno(
      {required int idCurso}) async {
    final List<AlunoEntity> alunos = [];
    var url = Uri.http('10.0.2.2:3000', '/alunos/aluno_matricula/$idCurso');

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        return throw GetMatriculaAlunoException(StackTrace.current,
            'GetMatriculaAluno', "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      for (var aluno in data) {
        alunos.add(AlunoEntity.fromJson(aluno));
      }

      return Right(alunos);
    } catch (exception, stacktrace) {
      return Left(throw GetMatriculaAlunoException(
          stacktrace, 'GetMatriculaAluno', exception));
    }
  }

  @override
  Future<Either<CoreFailure, List<MatriculaEntity>>> post(
      {required List<MatriculaEntity> matriculas}) async {
    var url = Uri.http('10.0.2.2:3000', '/matricula/');
    final List<MatriculaEntity> resultList = [];

    try {
      final result = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(matriculas),
      );
      if (result.statusCode != 200) {
        return throw PostMatriculaException(StackTrace.current, 'PostMatricula',
            "StatusCode: ${result.statusCode}");
      }

      return Right(resultList);
    } catch (exception, stacktrace) {
      return Left(throw GetCursosException(stacktrace, 'GetCursos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, MatriculaEntity>> delete(
      {required MatriculaEntity matricula}) async {
    var url = Uri.http('10.0.2.2:3000', '/matricula/${matricula.id}');

    try {
      final result = await http.delete(url);

      if (result.statusCode != 200) {
        return throw DeleteMatriculaException(StackTrace.current,
            'DeleteMatricula', "StatusCode: ${result.statusCode}");
      }

      return Right(matricula);
    } catch (exception, stacktrace) {
      return Left(throw DeleteMatriculaException(
          stacktrace, 'DeleteMatricula', exception));
    }
  }
}
