import 'dart:convert';

import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/aluno/domain/interfaces/ialuno_repository.dart';
import 'package:flutter_escola/aluno/error_handling/exceptions.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AlunoRepository implements IAlunoRepository {
  @override
  Future<Either<CoreFailure, List<AlunoEntity>>> getAlunos() async {
    final List<AlunoEntity> alunos = [];
    var url = Uri.http('10.0.2.2:3000', '/alunos/');

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        return throw GetAlunosException(StackTrace.current, 'GetAlunos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      for (var aluno in data) {
        alunos.add(AlunoEntity.fromJson(aluno));
      }

      return Right(alunos);
    } catch (exception, stacktrace) {
      return Left(throw GetAlunosException(stacktrace, 'GetAlunos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, AlunoEntity>> getAlunoById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, AlunoEntity>> postAluno(
      {required AlunoEntity aluno}) async {
    var url = Uri.http('10.0.2.2:3000', '/alunos/');

    try {
      final result = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nome': aluno.nome,
        }),
      );
      if (result.statusCode != 200) {
        return throw PostAlunosException(StackTrace.current, 'PostAlunos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      return Right(AlunoEntity.fromJson(data));
    } catch (exception, stacktrace) {
      return Left(throw GetAlunosException(stacktrace, 'GetAlunos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, AlunoEntity>> deleteAluno(
      {required AlunoEntity aluno}) async {
    var url = Uri.http('10.0.2.2:3000', '/alunos/${aluno.id}');

    try {
      final result = await http.delete(url);
      if (result.statusCode == 403) {
        aluno = AlunoEntity(nome: '', id: -1);
      } else if (result.statusCode != 200) {
        return throw PostAlunosException(StackTrace.current, 'DeleteAlunos',
            "StatusCode: ${result.statusCode}");
      }

      return Right(aluno);
    } catch (exception, stacktrace) {
      return Left(
          throw PostAlunosException(stacktrace, 'DeleteAlunos', exception));
    }
  }

  @override
  Future<Either<CoreFailure, AlunoEntity>> putAluno(
      {required AlunoEntity aluno}) async {
    var url = Uri.http('10.0.2.2:3000', '/alunos/${aluno.id}');

    try {
      final result = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nome': aluno.nome,
        }),
      );
      if (result.statusCode != 200) {
        return throw PutAlunosException(StackTrace.current, 'PutAlunos',
            "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      return Right(AlunoEntity.fromJson(data));
    } catch (exception, stacktrace) {
      return Left(throw PutAlunosException(stacktrace, 'PutAlunos', exception));
    }
  }
}
