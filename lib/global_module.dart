import 'package:flutter_escola/course/curso_module.dart';
import 'package:flutter_escola/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalModule extends Module {
  @override
  List<Module> imports = [
    CursoModule(),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/curso', module: CursoModule()),
  ];
}
