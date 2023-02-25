import 'package:flutter/material.dart';
import 'package:flutter_escola/curso_page.dart';
import 'package:flutter_escola/widgets/my_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6D00),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter - Escola'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final String titleCurso = 'Cursos';
  final String titleAluno = 'Alunos';

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
                InkWell(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CursoPage(
                                  title: titleCurso,
                                )),
                      );
                    },
                    title: Text(titleCurso),
                    leading: const Icon(Icons.school),
                  ),
                ),
                InkWell(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CursoPage(
                                  title: titleAluno,
                                )),
                      );
                    },
                    title: Text(titleAluno),
                    leading: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container());
  }
}
