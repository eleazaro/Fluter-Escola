import 'package:dartz/dartz.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/aluno/domain/interfaces/ialuno_repository.dart';
import 'package:flutter_escola/aluno/domain/services/get_aluno_service.dart';
import 'package:flutter_escola/aluno/error_handling/failure.dart';
import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock with IAlunoRepository {}

void main() {
  late IAlunoRepository repository;
  late GetAlunoService service;

  setUpAll(() {
    repository = MockRepository();
    service = GetAlunoService(repository);
  });

  List<AlunoEntity> listEntity = [
    AlunoEntity(nome: 'Aluno1'),
    AlunoEntity(nome: 'Aluno2'),
  ];

  test('return a List<AlunoEntity> on successful return from the repository',
      () async {
    when(() => repository.getAlunos())
        .thenAnswer((_) async => Right(listEntity));
    final Either<CoreFailure, List<AlunoEntity>> result = await service.call();

    expect(result, Right(listEntity));

    verify(() => repository.getAlunos()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('return a Failure on unsuccessful return from the repository', () async {
    when(() => repository.getAlunos())
        .thenAnswer((_) async => Left(GetAlunosFailure()));
    final Either<CoreFailure, List<AlunoEntity>> result = await service.call();
    expect(result, Left(GetAlunosFailure()));
    verify(() => repository.getAlunos()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
