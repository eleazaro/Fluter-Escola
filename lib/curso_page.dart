import 'package:flutter/material.dart';
import 'package:flutter_escola/widgets/my_appbar.dart';
import 'package:flutter_escola/widgets/my_dialog.dart';

import 'curso_detail_page.dart';

class CursoPage extends StatefulWidget {
  final String title;
  const CursoPage({
    super.key,
    required this.title,
  });

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  final _list = ['Curso 1', 'Curso 2', 'Curso 3', 'Curso 4', 'Curso 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CursoDetailPage(
                      title: _list[index],
                      description: 'ementa',
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(_list[index]),
                trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      MyDialog(
                        context: context,
                        item: _list[index],
                      ).showMyDialog();
                    }),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: _list.length),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[600],
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
