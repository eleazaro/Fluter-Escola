import 'package:flutter/widgets.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/domain/services/get_curso_service.dart';

enum CursoState { loading, success, failure }

class CursoController extends ChangeNotifier {
  final GetCursoService _getCursosService;

  ValueNotifier<CursoState> state =
      ValueNotifier<CursoState>(CursoState.loading);
  late List<CursoEntity> _cursos = [];

  List<CursoEntity> get cursos => _cursos;

  CursoController(
    this._getCursosService,
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
}
