import 'package:flutter/widgets.dart';
import 'package:flutter_escola/aluno/entities/aluno_entity.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/services/get_matricula_aluno_service.dart';

enum CursoMatriculaState { loading, success, failure, empty }

class CursoMatriculaController extends ChangeNotifier {
  final GetMatriculaAlunoService _getMatriculaAlunoService;

  ValueNotifier<CursoMatriculaState> state =
      ValueNotifier<CursoMatriculaState>(CursoMatriculaState.loading);
  late final List<MatriculaEntity> _matriculas = [];

  List<MatriculaEntity> get matriculas => _matriculas;

  CursoMatriculaController(
    this._getMatriculaAlunoService,
  );
  void init() async {
    state.value = CursoMatriculaState.loading;
    _matriculas.clear();
    state.notifyListeners();
  }

  void get({required int idCurso}) async {
    state.value = CursoMatriculaState.loading;

    final serviceRequest =
        await _getMatriculaAlunoService.call(idCurso: idCurso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<AlunoEntity>) {
      for (var aluno in result) {
        _matriculas.add(MatriculaEntity(nome: aluno.nome, idAluno: aluno.id));
      }

      if (_matriculas.isEmpty) {
        state.value = CursoMatriculaState.empty;
      } else {
        state.value = CursoMatriculaState.success;
      }

      state.notifyListeners();
    } else {
      state.value = CursoMatriculaState.failure;
      state.notifyListeners();
    }
  }

  void tapCheckbox({required int index}) {
    bool matricular = _matriculas[index].matricular!;
    _matriculas[index].matricular = !matricular;
    state.notifyListeners();
  }
}
