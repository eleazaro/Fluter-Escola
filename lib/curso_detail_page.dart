import 'package:flutter/material.dart';
import 'package:flutter_escola/widgets/my_appbar.dart';
import 'package:flutter_escola/widgets/my_dialog.dart';

class CursoDetailPage extends StatefulWidget {
  final String title;
  final String description;
  const CursoDetailPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<CursoDetailPage> createState() => _CursoDetailPageState();
}

class _CursoDetailPageState extends State<CursoDetailPage> {
  final _list = ['Aluno 1', 'Aluno 2', 'Aluno 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.title),
      body: Column(
        children: [
          Text(widget.description),
          ListView.separated(
              shrinkWrap: true,
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
              itemCount: _list.length)
        ],
      ),
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
