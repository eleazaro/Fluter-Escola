import 'package:flutter/material.dart';
import 'package:flutter_escola/course/presentation/controller/curso_matricula_controller.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/padding_values.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CursoMatriculaPage extends StatefulWidget {
  final int idCurso;
  const CursoMatriculaPage({
    super.key,
    required this.idCurso,
  });

  @override
  State<CursoMatriculaPage> createState() => _CursoMatriculaPageState();
}

class _CursoMatriculaPageState extends State<CursoMatriculaPage> {
  final CursoMatriculaController _controller = Modular.get();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    _controller.get(idCurso: widget.idCurso);

    final controllerTitle = TextEditingController();

    return ValueListenableBuilder<CursoMatriculaState>(
        valueListenable: _controller.state,
        builder: (context, state, _) {
          switch (state) {
            case CursoMatriculaState.loading:
              return const Center(child: CircularProgressIndicator());

            case CursoMatriculaState.failure:
              return const Center(child: Text('Erro'));

            case CursoMatriculaState.empty:
              return SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(FixedString.allStudents),
                ),
              );

            case CursoMatriculaState.success:
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
                          padding: EdgeInsets.only(top: PaddingValues.xxvalue),
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
                                      value: _controller
                                          .matriculas[index].matricular,
                                      selected: false,
                                      onChanged: (value) {
                                        _controller.tapCheckbox(index: index);
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
                              onPressed: () {
                                _controller.post(idCurso: widget.idCurso);
                                Navigator.of(context).pop();
                              },
                              child: Text(FixedString.save))
                        ],
                      )
                    ],
                  ),
                ),
              );
          }
        });
  }
}
