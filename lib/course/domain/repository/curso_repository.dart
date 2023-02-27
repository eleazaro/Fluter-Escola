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
}
