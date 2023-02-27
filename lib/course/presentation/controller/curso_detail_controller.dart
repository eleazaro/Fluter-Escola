import 'package:flutter/widgets.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/services/delete_matricula_service.dart';
import 'package:flutter_escola/course/domain/services/get_matricula_curso_service.dart';

enum CursoDetailState { loading, success, failure, empty }

class CursoDetailController extends ChangeNotifier {
  final GetMatriculaCursoService _getMatriculaCursosService;
  final DeleteMatriculaService _deleteMatriculaService;

  ValueNotifier<CursoDetailState> state =
      ValueNotifier<CursoDetailState>(CursoDetailState.loading);
  late List<MatriculaEntity> _matriculas = [];

  List<MatriculaEntity> get matriculas => _matriculas;

  CursoDetailController(
    this._getMatriculaCursosService,
    this._deleteMatriculaService,
  );
  void init() async {
    state.value = CursoDetailState.loading;
    state.notifyListeners();
  }

  void get({required int idCurso}) async {
    state.value = CursoDetailState.loading;

    final serviceRequest =
        await _getMatriculaCursosService.call(idCurso: idCurso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<MatriculaEntity>) {
      _matriculas = result;
      if (_matriculas.isEmpty) {
        state.value = CursoDetailState.empty;
      } else {
        state.value = CursoDetailState.success;
      }

      state.notifyListeners();
    } else {
      state.value = CursoDetailState.failure;
      state.notifyListeners();
    }
  }

  void delete({required MatriculaEntity matricula}) async {
    state.value = CursoDetailState.loading;

    final serviceRequest = await _deleteMatriculaService(matricula: matricula);

    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is MatriculaEntity) {
      _matriculas.remove(result);
      state.value = CursoDetailState.success;
    } else {
      state.value = CursoDetailState.failure;
    }
    state.notifyListeners();
  }
}
