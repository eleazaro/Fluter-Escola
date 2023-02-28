import 'package:flutter_escola/aluno/aluno_module.dart';
import 'package:flutter_escola/course/curso_module.dart';
import 'package:flutter_escola/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalModule extends Module {
  @override
  List<Module> imports = [
    CursoModule(),
    AlunoModule(),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/aluno', module: AlunoModule()),
    ModuleRoute('/curso', module: CursoModule()),
  ];
}
