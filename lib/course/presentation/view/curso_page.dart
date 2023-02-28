import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/presentation/controller/curso_controller.dart';
import 'package:flutter_escola/shared/widgets/animated_bottom_sheet.dart';
import 'package:flutter_escola/course/presentation/widgets/item_list.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
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
                          child: index == (_controller.cursos.length - 1)
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: PaddingValues.xbig),
                                  child: ItemList(
                                    index: index,
                                  ),
                                )
                              : ItemList(
                                  index: index,
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
                return AnimatedBottomSheet(
                  onShow: () => _controller.init(),
                  description: FixedString.haveStudent,
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
