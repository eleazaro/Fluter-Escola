import 'package:flutter/material.dart';
import 'package:flutter_escola/chart.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: MyAppBar(
          title: widget.title,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Modular.to.pushNamed(
                      '/curso/${FixedString.menuCourse}',
                    );
                  },
                  title: Text(FixedString.menuCourse),
                  leading: const Icon(Icons.school),
                ),
                ListTile(
                  onTap: () {
                    Modular.to.pushNamed('/aluno/${FixedString.menuStudent}');
                  },
                  title: Text(FixedString.menuStudent),
                  leading: const Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
        body: const Chart());
  }
}
