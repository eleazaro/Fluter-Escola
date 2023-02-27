import 'package:flutter/material.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/presentation/controller/curso_detail_controller.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
import 'package:flutter_escola/shared/widgets/my_dialog.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursoDetailPage extends StatefulWidget {
  final CursoEntity curso;

  const CursoDetailPage({
    super.key,
    required this.curso,
  });

  @override
  State<CursoDetailPage> createState() => _CursoDetailPageState();
}

class _CursoDetailPageState extends State<CursoDetailPage> {
  final CursoDetailController _controller = Modular.get();
  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    _controller.get(idCurso: widget.curso.id!);

    return Scaffold(
      appBar: MyAppBar(title: widget.curso.descricao),
      body: ValueListenableBuilder<CursoDetailState>(
          valueListenable: _controller.state,
          builder: (context, state, _) {
            switch (state) {
              case CursoDetailState.loading:
                return const Center(child: CircularProgressIndicator());

              case CursoDetailState.failure:
                return const Center(child: Text('Erro'));

              case CursoDetailState.empty:
                return Center(
                  child: Text(FixedString.emptyStudents),
                );

              case CursoDetailState.success:
                return Column(
                  children: [
                    Card(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: EdgeInsets.all(PaddingValues.xvalue),
                          child: Center(child: Text(widget.curso.ementa)),
                        )),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_controller.matriculas[index].nome),
                            trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  MyDialog(
                                    context: context,
                                    item: _controller.matriculas[index].nome,
                                  ).showMyDialog();
                                }),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: _controller.matriculas.length)
                  ],
                );
            }
          }),
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
                                        title: Text(
                                            _controller.matriculas[index].nome),
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
                                  itemCount: _controller.matriculas.length),
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
