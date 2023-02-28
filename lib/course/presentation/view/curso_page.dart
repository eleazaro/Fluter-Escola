import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/presentation/controller/curso_controller.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
import 'package:flutter_escola/shared/widgets/my_dialog.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursoPage extends StatefulWidget {
  final String title;
  const CursoPage({super.key, required this.title});

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> with TickerProviderStateMixin {
  final CursoController _controller = Modular.get<CursoController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
      ),
      body: ValueListenableBuilder<CursoState>(
          valueListenable: _controller.state,
          builder: (context, state, _) {
            switch (state) {
              case CursoState.success:
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Modular.to.pushNamed('/curso/detail/',
                                arguments: _controller.cursos[index]);
                          },
                          child: ListTile(
                            title: Text(_controller.cursos[index].descricao),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: PaddingValues.value,
                                            vertical: PaddingValues.xvalue),
                                        child: Wrap(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.delete),
                                              title: Text(FixedString.delete),
                                              onTap: () {
                                                MyDialog(
                                                        onConfirm: () {
                                                          _controller.delete(
                                                              curso: _controller
                                                                      .cursos[
                                                                  index]);
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        context: context,
                                                        item: _controller
                                                            .cursos[index]
                                                            .descricao)
                                                    .showMyDialog();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: Text(FixedString.alter),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (context) {
                                                      final controllerTitle =
                                                          TextEditingController(
                                                              text: _controller
                                                                  .cursos[index]
                                                                  .descricao);
                                                      final controllerDescription =
                                                          TextEditingController(
                                                              text: _controller
                                                                  .cursos[index]
                                                                  .ementa);
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                PaddingValues
                                                                    .xxvalue,
                                                            vertical:
                                                                PaddingValues
                                                                    .xxxvalue,
                                                          ),
                                                          child: Wrap(
                                                            children: [
                                                              TextFormField(
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .words,
                                                                controller:
                                                                    controllerTitle,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: PaddingValues
                                                                        .xxvalue),
                                                                child:
                                                                    TextField(
                                                                  inputFormatters: [
                                                                    LengthLimitingTextInputFormatter(
                                                                        50),
                                                                  ],
                                                                  maxLines: 2,
                                                                  controller:
                                                                      controllerDescription,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          FixedString
                                                                              .cancel)),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        _controller
                                                                            .put(
                                                                          curso: CursoEntity(
                                                                              descricao: controllerTitle.text,
                                                                              ementa: controllerDescription.text,
                                                                              id: _controller.cursos[index].id),
                                                                          index:
                                                                              index,
                                                                        );
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          FixedString
                                                                              .alter))
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: _controller.cursos.length);

              case CursoState.loading:
                return const CircularProgressIndicator();

              case CursoState.failure:
                return const Center(child: Text('Erro'));
              case CursoState.forbidden:
                return InkWell(
                  onTap: () {
                    _controller.init();
                  },
                  child: Container(
                    color: Colors.red,
                  ),
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
                final controllerTitle = TextEditingController();
                final controllerDescription = TextEditingController();
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: PaddingValues.xxvalue,
                      vertical: PaddingValues.xxxvalue,
                    ),
                    child: Wrap(
                      children: [
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: controllerTitle,
                          decoration: InputDecoration(
                            hintText: FixedString.course,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: PaddingValues.xxvalue),
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            maxLines: 2,
                            controller: controllerDescription,
                            decoration: InputDecoration(
                              hintText: FixedString.descriptionCourse,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(FixedString.cancel)),
                            TextButton(
                                onPressed: () {
                                  _controller.post(
                                      curso: CursoEntity(
                                          descricao: controllerTitle.text,
                                          ementa: controllerDescription.text));
                                  Navigator.of(context).pop();
                                },
                                child: Text(FixedString.save))
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
