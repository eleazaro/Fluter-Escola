import 'package:flutter/widgets.dart';
import 'package:flutter_escola/aluno/entities/aluno_entity.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/services/get_matricula_aluno_service.dart';
import 'package:flutter_escola/course/domain/services/post_curso_service%20copy.dart';
import 'package:flutter_escola/course/presentation/controller/curso_detail_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum CursoMatriculaState { loading, success, failure, empty }

class CursoMatriculaController extends ChangeNotifier {
  final GetMatriculaAlunoService _getMatriculaAlunoService;
  final PostMatriculaService _postMatriculaService;

  ValueNotifier<CursoMatriculaState> state =
      ValueNotifier<CursoMatriculaState>(CursoMatriculaState.loading);
  late final List<MatriculaEntity> _matriculas = [];

  List<MatriculaEntity> get matriculas => _matriculas;

  CursoMatriculaController(
    this._getMatriculaAlunoService,
    this._postMatriculaService,
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
        _matriculas.add(MatriculaEntity(
          nome: aluno.nome,
          idAluno: aluno.id,
          idCurso: idCurso,
        ));
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

  void post({required int idCurso}) async {
    final CursoDetailController _controllerDetail = Modular.get();

    state.value = CursoMatriculaState.loading;
    final List<MatriculaEntity> checkedList =
        verifyChecked(matriculas: _matriculas);

    final serviceRequest = await _postMatriculaService(matriculas: checkedList);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<MatriculaEntity>) {
      state.value = CursoMatriculaState.success;
      state.notifyListeners();
    } else {
      state.value = CursoMatriculaState.failure;
      state.notifyListeners();
    }
    _controllerDetail.get(idCurso: idCurso);
  }

  List<MatriculaEntity> verifyChecked(
      {required List<MatriculaEntity> matriculas}) {
    final List<MatriculaEntity> checkedList = [];

    for (var matricula in matriculas) {
      if (matricula.matricular) {
        checkedList.add(matricula);
      }
    }
    return checkedList;
  }

  void tapCheckbox({required int index}) {
    bool matricular = _matriculas[index].matricular;
    _matriculas[index].matricular = !matricular;
    state.notifyListeners();
  }
}
