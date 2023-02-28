import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/presentation/controller/curso_controller.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_escola/shared/widgets/my_dialog.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ItemList extends StatefulWidget {
  final int index;
  const ItemList({super.key, required this.index});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final CursoController _controller = Modular.get<CursoController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_controller.cursos[widget.index].descricao),
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
                                        curso:
                                            _controller.cursos[widget.index]);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  context: context,
                                  item: _controller
                                      .cursos[widget.index].descricao)
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
                                final controllerTitle = TextEditingController(
                                    text: _controller
                                        .cursos[widget.index].descricao);
                                final controllerDescription =
                                    TextEditingController(
                                        text: _controller
                                            .cursos[widget.index].ementa);
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
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controller: controllerTitle,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: PaddingValues.xxvalue),
                                          child: TextField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  50),
                                            ],
                                            maxLines: 2,
                                            controller: controllerDescription,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:
                                                    Text(FixedString.cancel)),
                                            TextButton(
                                                onPressed: () {
                                                  _controller.put(
                                                    curso: CursoEntity(
                                                        descricao:
                                                            controllerTitle
                                                                .text,
                                                        ementa:
                                                            controllerDescription
                                                                .text,
                                                        id: _controller
                                                            .cursos[
                                                                widget.index]
                                                            .id),
                                                    index: widget.index,
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(FixedString.alter))
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
    );
  }
}
