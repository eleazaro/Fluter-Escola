import 'dart:convert';

import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/icurso_repository.dart';
import 'package:flutter_escola/course/error_handling/exceptions.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CursoRepository implements ICursoRepository {
  @override
  Future<Either<CoreFailure, List<CursoEntity>>> getCursos() async {
    final List<CursoEntity> cursos = [];
    var url = Uri.http('10.0.2.2:3000', '/cursos/');

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        return throw GetCursosException(StackTrace.current, 'GetCursos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      for (var curso in data) {
        cursos.add(CursoEntity.fromJson(curso));
      }

      return Right(cursos);
    } catch (exception, stacktrace) {
      return Left(throw GetCursosException(stacktrace, 'GetCursos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, CursoEntity>> getCursoById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, CursoEntity>> postCurso(
      {required CursoEntity curso}) async {
    var url = Uri.http('10.0.2.2:3000', '/cursos/');

    try {
      final result = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'descricao': curso.descricao,
          'ementa': curso.ementa,
        }),
      );
      if (result.statusCode != 200) {
        return throw PostCursosException(StackTrace.current, 'PostCursos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      return Right(CursoEntity.fromJson(data));
    } catch (exception, stacktrace) {
      return Left(throw GetCursosException(stacktrace, 'GetCursos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, CursoEntity>> deleteCurso(
      {required CursoEntity curso}) async {
    var url = Uri.http('10.0.2.2:3000', '/cursos/${curso.id}');

    try {
      final result = await http.delete(url);
      if (result.statusCode == 403) {
        curso = CursoEntity(descricao: '', ementa: '', id: -1);
      } else if (result.statusCode != 200) {
        return throw PostCursosException(StackTrace.current, 'DeleteCursos',
            "StatusCode: ${result.statusCode}");
      }

      return Right(curso);
    } catch (exception, stacktrace) {
      return Left(
          throw PostCursosException(stacktrace, 'DeleteCursos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, CursoEntity>> putCurso(
      {required CursoEntity curso}) async {
    var url = Uri.http('10.0.2.2:3000', '/cursos/${curso.id}');

    try {
      final result = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'descricao': curso.descricao,
          'ementa': curso.ementa,
        }),
      );
      if (result.statusCode != 200) {
        return throw PutCursosException(StackTrace.current, 'PutCursos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      return Right(CursoEntity.fromJson(data));
    } catch (exception, stacktrace) {
      return Left(throw PutCursosException(stacktrace, 'PutCursos', exception));
    }
  }
}
