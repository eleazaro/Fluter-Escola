import 'package:flutter_escola/aluno/data/repository/aluno_repository.dart';
import 'package:flutter_escola/aluno/domain/services/delete_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/get_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/post_aluno_service.dart';
import 'package:flutter_escola/aluno/domain/services/put_aluno_service.dart';
import 'package:flutter_escola/aluno/presentation/view/aluno_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/controller/aluno_page_controller.dart';

class AlunoModule extends Module {
  @override
  final List<Bind> binds = [
    /// ------------------------------- Repositories ---------------------------
    Bind.lazySingleton((i) => AlunoRepository(), export: true),

    /// ------------------------------- Services -------------------------------
    Bind.lazySingleton((i) => GetAlunoService(i()), export: true),
    Bind.lazySingleton((i) => PostAlunoService(i()), export: true),
    Bind.lazySingleton((i) => DeleteAlunoService(i()), export: true),
    Bind.lazySingleton((i) => PutAlunoService(i()), export: true),

    /// ------------------------------- State ----------------------------------
    Bind.lazySingleton(
        (i) => AlunoPageController(
              i(),
              i(),
              i(),
              i(),
            ),
        export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:aluno',
        child: (_, args) => AlunoPage(title: args.params['aluno'])),
  ];
}
