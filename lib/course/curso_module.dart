import 'package:flutter_escola/course/data/repository/curso_repository.dart';
import 'package:flutter_escola/course/data/repository/matricula_repository.dart';
import 'package:flutter_escola/course/domain/services/delete_curso_service.dart';
import 'package:flutter_escola/course/domain/services/delete_matricula_service.dart';
import 'package:flutter_escola/course/domain/services/get_curso_service.dart';
import 'package:flutter_escola/course/domain/services/get_matricula_curso_service.dart';
import 'package:flutter_escola/course/domain/services/post_matricula_service.dart';
import 'package:flutter_escola/course/domain/services/post_curso_service.dart';
import 'package:flutter_escola/course/domain/services/put_curso_service.dart';
import 'package:flutter_escola/course/presentation/controller/curso_controller.dart';
import 'package:flutter_escola/course/presentation/controller/curso_detail_controller.dart';
import 'package:flutter_escola/course/presentation/controller/curso_matricula_controller.dart';
import 'package:flutter_escola/course/presentation/view/curso_detail_page.dart';
import 'package:flutter_escola/course/presentation/view/curso_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/services/get_matricula_aluno_service.dart';

class CursoModule extends Module {
  @override
  final List<Bind> binds = [
    /// ------------------------------- Repositories ---------------------------
    Bind.lazySingleton((i) => CursoRepository(), export: true),
    Bind.lazySingleton((i) => MatriculaRepository(), export: true),

    /// ------------------------------- Services -------------------------------
    Bind.lazySingleton((i) => GetCursoService(i()), export: true),
    Bind.lazySingleton((i) => PostCursoService(i()), export: true),
    Bind.lazySingleton((i) => DeleteCursoService(i()), export: true),
    Bind.lazySingleton((i) => PutCursoService(i()), export: true),
    Bind.lazySingleton((i) => GetMatriculaCursoService(i()), export: true),
    Bind.lazySingleton((i) => GetMatriculaAlunoService(i()), export: true),
    Bind.lazySingleton((i) => PostMatriculaService(i()), export: true),
    Bind.lazySingleton((i) => DeleteMatriculaService(i()), export: true),

    /// ------------------------------- State ----------------------------------
    Bind.lazySingleton(
        (i) => CursoController(
              i(),
              i(),
              i(),
              i(),
            ),
        export: true),

    Bind.lazySingleton(
        (i) => CursoDetailController(
              i(),
              i(),
            ),
        export: true),

    Bind.lazySingleton(
        (i) => CursoMatriculaController(
              i(),
              i(),
            ),
        export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:title',
        child: (_, args) => CursoPage(title: args.params['title'])),
    ChildRoute('/detail/',
        child: (_, args) => CursoDetailPage(curso: args.data)),
  ];
}
