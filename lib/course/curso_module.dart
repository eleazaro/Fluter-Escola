import 'package:flutter_escola/course/domain/services/get_curso_service.dart';
import 'package:flutter_escola/course/presentation/controller/curso_controller.dart';
import 'package:flutter_escola/course/presentation/view/curso_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repository/curso_repository.dart';

class CursoModule extends Module {
  @override
  final List<Bind> binds = [
    /// ------------------------------- Repositories ---------------------------
    Bind.lazySingleton((i) => CursoRepository(), export: true),

    /// ------------------------------- Services -------------------------------
    Bind.lazySingleton((i) => GetCursoService(i()), export: true),

    /// ------------------------------- State ----------------------------------
    Bind.lazySingleton(
        (i) => CursoController(
              i(),
            ),
        export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:title',
        child: (_, args) => CursoPage(title: args.params['title'])),
  ];
}
