import 'package:flutter/widgets.dart';
import 'package:flutter_escola/aluno/domain/entities/aluno_entity.dart';
import 'package:flutter_escola/aluno/domain/services/delete_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/get_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/post_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/put_aluno_service.dart';

enum AlunoState { loading, success, failure, forbidden }

class AlunoPageController extends ChangeNotifier {
  final GetAlunoService _getAlunosService;
  final PostAlunoService _postAlunoService;
  final DeleteAlunoService _deleteAlunoService;
  final PutAlunoService _putAlunoService;

  ValueNotifier<AlunoState> state =
      ValueNotifier<AlunoState>(AlunoState.loading);
  late List<AlunoEntity> _alunos = [];

  List<AlunoEntity> get alunos => _alunos;

  AlunoPageController(
    this._getAlunosService,
    this._postAlunoService,
    this._deleteAlunoService,
    this._putAlunoService,
  );

  void init() async {
    state.value = AlunoState.loading;

    final serviceRequest = await _getAlunosService.call();
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<AlunoEntity>) {
      _alunos = result;
      state.value = AlunoState.success;
      state.notifyListeners();
    } else {
      state.value = AlunoState.failure;
      state.notifyListeners();
    }
  }

  void post({required AlunoEntity aluno}) async {
    state.value = AlunoState.loading;

    final serviceRequest = await _postAlunoService(aluno: aluno);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is AlunoEntity) {
      _alunos.add(result);
      state.value = AlunoState.success;
      state.notifyListeners();
    } else {
      state.value = AlunoState.failure;
      state.notifyListeners();
    }
  }

  void delete({required AlunoEntity aluno}) async {
    state.value = AlunoState.loading;

    final serviceRequest = await _deleteAlunoService(aluno: aluno);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is AlunoEntity) {
      if (result.id == -1) {
        state.value = AlunoState.forbidden;
      } else {
        _alunos.remove(result);
        state.value = AlunoState.success;
      }
      state.notifyListeners();
    } else {
      state.value = AlunoState.failure;
      state.notifyListeners();
    }
  }

  void put({required AlunoEntity aluno, required int index}) async {
    state.value = AlunoState.loading;

    final serviceRequest = await _putAlunoService(aluno: aluno);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is AlunoEntity) {
      _alunos[index] = result;
      state.value = AlunoState.success;
      state.notifyListeners();
    } else {
      state.value = AlunoState.failure;
      state.notifyListeners();
    }
  }
}
