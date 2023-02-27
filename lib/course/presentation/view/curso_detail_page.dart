import 'package:flutter/material.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
import 'package:flutter_escola/shared/widgets/my_dialog.dart';

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
  final _listAll = [
    'Aluno 1',
    'Aluno 2',
    'Aluno 3',
    'Aluno 1',
    'Aluno 2',
    'Aluno 3',
    'Aluno 1',
    'Aluno 2',
    'Aluno 3',
    'Aluno 1',
    'Aluno 2',
    'Aluno 3'
  ];

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
                          description:
                              'Ementa do curso esta com um total de 50 caracteres',
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(_list[index]),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
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
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                final listAllValue = [
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                ];
                final controllerTitle = TextEditingController();

                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: PaddingValues.xxvalue,
                      vertical: PaddingValues.xxxvalue,
                    ),
                    child: Wrap(
                      children: [
                        TextField(
                          controller: controllerTitle,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            hintText: FixedString.searchStudent,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: PaddingValues.xxvalue),
                            child: Container(
                              decoration: const BoxDecoration(border: Border()),
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                        activeColor: Colors.blue[800],
                                        dense: true,
                                        title: Text(_listAll[index]),
                                        value: listAllValue[index],
                                        selected: listAllValue[index],
                                        onChanged: (value) {
                                          setState(() {
                                            listAllValue[index] = value!;
                                          });
                                        });
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: _listAll.length),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(FixedString.cancel)),
                            TextButton(
                                onPressed: () {}, child: Text(FixedString.save))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
