import 'package:flutter/material.dart';
import 'package:flutter_escola/course/domain/entities/curso_entity.dart';
import 'package:flutter_escola/course/presentation/controller/curso_detail_controller.dart';
import 'package:flutter_escola/course/presentation/view/curso_matricula_page.dart';
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
              builder: (context) =>
                  CursoMatriculaPage(idCurso: widget.curso.id!));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
