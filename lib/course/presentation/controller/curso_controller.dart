import 'package:flutter/widgets.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/domain/services/delete_curso_service.dart';
import 'package:flutter_escola/course/domain/services/get_curso_service.dart';
import 'package:flutter_escola/course/domain/services/post_curso_service.dart';
import 'package:flutter_escola/course/domain/services/put_curso_service.dart';

enum CursoState { loading, success, failure }

class CursoController extends ChangeNotifier {
  final GetCursoService _getCursosService;
  final PostCursoService _postCursoService;
  final DeleteCursoService _deleteCursoService;
  final PutCursoService _putCursoService;

  ValueNotifier<CursoState> state =
      ValueNotifier<CursoState>(CursoState.loading);
  late List<CursoEntity> _cursos = [];

  List<CursoEntity> get cursos => _cursos;

  CursoController(
    this._getCursosService,
    this._postCursoService,
    this._deleteCursoService,
    this._putCursoService,
  );

  void init() async {
    state.value = CursoState.loading;

    final serviceRequest = await _getCursosService.call();
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is List<CursoEntity>) {
      _cursos = result;
      state.value = CursoState.success;
      state.notifyListeners();
    } else {
      state.value = CursoState.failure;
      state.notifyListeners();
    }
  }

  void post({required CursoEntity curso}) async {
    state.value = CursoState.loading;

    final serviceRequest = await _postCursoService(curso: curso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is CursoEntity) {
      _cursos.add(result);
      state.value = CursoState.success;
      state.notifyListeners();
    } else {
      state.value = CursoState.failure;
      state.notifyListeners();
    }
  }

  void delete({required CursoEntity curso}) async {
    state.value = CursoState.loading;

    final serviceRequest = await _deleteCursoService(curso: curso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is CursoEntity) {
      _cursos.remove(result);
      state.value = CursoState.success;
      state.notifyListeners();
    } else {
      state.value = CursoState.failure;
      state.notifyListeners();
    }
  }

  void put({required CursoEntity curso, required int index}) async {
    state.value = CursoState.loading;

    final serviceRequest = await _putCursoService(curso: curso);
    final result = serviceRequest.fold((l) => l, (r) => r);
    if (result is CursoEntity) {
      _cursos[index] = result;
      state.value = CursoState.success;
      state.notifyListeners();
    } else {
      state.value = CursoState.failure;
      state.notifyListeners();
    }
  }
}
