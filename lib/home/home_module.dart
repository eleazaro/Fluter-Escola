import 'package:flutter_escola/course/presentation/view/curso_page.dart';
import 'package:flutter_escola/home/presentation/view/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => const HomePage(
              title: 'Flutter - Escola',
            )),
  ];
}
