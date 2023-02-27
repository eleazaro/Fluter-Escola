import 'package:flutter/widgets.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/services/get_matricula_curso_service.dart';

enum CursoDetailState { loading, success, failure }

class CursoDetailController extends ChangeNotifier {
  final GetMatriculaCursoService _getMatriculaCursosService;

  ValueNotifier<CursoDetailState> state =
      ValueNotifier<CursoDetailState>(CursoDetailState.loading);
  late List<MatriculaEntity> _matriculas = [];

  List<MatriculaEntity> get matriculas => _matriculas;

  CursoDetailController(
    this._getMatriculaCursosService,
  );

  void init({required int idCurso}) async {
    state.value = CursoDetailState.loading;

    final serviceRequest =
        await _getMatriculaCursosService.call(idCurso: idCurso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<MatriculaEntity>) {
      _matriculas = result;
      state.value = CursoDetailState.success;
      state.notifyListeners();
    } else {
      state.value = CursoDetailState.failure;
      state.notifyListeners();
    }
  }

  // void post({required CursoEntity curso}) async {
  //   state.value = CursoState.loading;

  //   final serviceRequest = await _postCursoService(curso: curso);
  //   final result = serviceRequest.fold((l) => l, (r) => r);
  //   if (result is CursoEntity) {
  //     _cursos.add(result);
  //     state.value = CursoState.success;
  //     state.notifyListeners();
  //   } else {
  //     state.value = CursoState.failure;
  //     state.notifyListeners();
  //   }
  // }

  // void delete({required CursoEntity curso}) async {
  //   state.value = CursoState.loading;

  //   final serviceRequest = await _deleteCursoService(curso: curso);
  //   final result = serviceRequest.fold((l) => l, (r) => r);
  //   if (result is CursoEntity) {
  //     _cursos.remove(result);
  //     state.value = CursoState.success;
  //     state.notifyListeners();
  //   } else {
  //     state.value = CursoState.failure;
  //     state.notifyListeners();
  //   }
  // }

  // void put({required CursoEntity curso, required int index}) async {
  //   state.value = CursoState.loading;

  //   final serviceRequest = await _putCursoService(curso: curso);
  //   final result = serviceRequest.fold((l) => l, (r) => r);
  //   if (result is CursoEntity) {
  //     _cursos[index] = result;
  //     state.value = CursoState.success;
  //     state.notifyListeners();
  //   } else {
  //     state.value = CursoState.failure;
  //     state.notifyListeners();
  //   }
  // }
}
