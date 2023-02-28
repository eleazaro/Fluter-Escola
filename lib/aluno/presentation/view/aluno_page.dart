import 'package:flutter/material.dart';
import 'package:flutter_escola/aluno/presentation/controller/aluno_page_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AlunoPage extends StatefulWidget {
  final String title;
  const AlunoPage({super.key, required this.title});

  @override
  State<AlunoPage> createState() => _AlunoPageState();
}

class _AlunoPageState extends State<AlunoPage> with TickerProviderStateMixin {
  final AlunoPageController _controller = Modular.get<AlunoPageController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   appBar: MyAppBar(
    //     title: widget.title,
    //   ),
    //   body: ValueListenableBuilder<AlunoState>(
    //       valueListenable: _controller.state,
    //       builder: (context, state, _) {
    //         switch (state) {
    //           case AlunoState.success:
    //             return ListView.separated(
    //                 itemBuilder: (context, index) {
    //                   return ListTile(
    //                     title: Text(_controller.alunos[index].nome),
    //                     trailing: IconButton(
    //                       icon: const Icon(Icons.more_horiz),
    //                       onPressed: () {
    //                         showModalBottomSheet(
    //                             context: context,
    //                             builder: (context) {
    //                               return Padding(
    //                                 padding: EdgeInsets.symmetric(
    //                                     horizontal: PaddingValues.value,
    //                                     vertical: PaddingValues.xvalue),
    //                                 child: Wrap(
    //                                   children: [
    //                                     ListTile(
    //                                       leading: const Icon(Icons.delete),
    //                                       title: Text(FixedString.delete),
    //                                       onTap: () {
    //                                         MyDialog(
    //                                                 onConfirm: () {
    //                                                   _controller.delete(
    //                                                       aluno: _controller
    //                                                           .alunos[index]);
    //                                                   Navigator.of(context)
    //                                                       .pop();
    //                                                   Navigator.of(context)
    //                                                       .pop();
    //                                                 },
    //                                                 context: context,
    //                                                 item: _controller
    //                                                     .alunos[index].nome)
    //                                             .showMyDialog();
    //                                       },
    //                                     ),
    //                                     ListTile(
    //                                       leading: const Icon(Icons.edit),
    //                                       title: Text(FixedString.alter),
    //                                       onTap: () {
    //                                         Navigator.of(context).pop();
    //                                         showModalBottomSheet(
    //                                             isScrollControlled: true,
    //                                             context: context,
    //                                             builder: (context) {
    //                                               final controllerTitle =
    //                                                   TextEditingController(
    //                                                       text: _controller
    //                                                           .alunos[index]
    //                                                           .nome);
    //                                               return Padding(
    //                                                 padding:
    //                                                     MediaQuery.of(context)
    //                                                         .viewInsets,
    //                                                 child: Padding(
    //                                                   padding:
    //                                                       EdgeInsets.symmetric(
    //                                                     horizontal:
    //                                                         PaddingValues
    //                                                             .xxvalue,
    //                                                     vertical: PaddingValues
    //                                                         .xxxvalue,
    //                                                   ),
    //                                                   child: Wrap(
    //                                                     children: [
    //                                                       TextFormField(
    //                                                         textCapitalization:
    //                                                             TextCapitalization
    //                                                                 .words,
    //                                                         controller:
    //                                                             controllerTitle,
    //                                                         decoration:
    //                                                             const InputDecoration(
    //                                                           border:
    //                                                               OutlineInputBorder(),
    //                                                         ),
    //                                                       ),
    //                                                       Row(
    //                                                         mainAxisAlignment:
    //                                                             MainAxisAlignment
    //                                                                 .spaceBetween,
    //                                                         children: [
    //                                                           TextButton(
    //                                                               onPressed:
    //                                                                   () {
    //                                                                 Navigator.of(
    //                                                                         context)
    //                                                                     .pop();
    //                                                               },
    //                                                               child: Text(
    //                                                                   FixedString
    //                                                                       .cancel)),
    //                                                           TextButton(
    //                                                               onPressed:
    //                                                                   () {
    //                                                                 _controller
    //                                                                     .put(
    //                                                                   aluno: AlunoEntity(
    //                                                                       nome: controllerTitle
    //                                                                           .text,
    //                                                                       id: _controller
    //                                                                           .alunos[index]
    //                                                                           .id),
    //                                                                   index:
    //                                                                       index,
    //                                                                 );
    //                                                                 Navigator.of(
    //                                                                         context)
    //                                                                     .pop();
    //                                                               },
    //                                                               child: Text(
    //                                                                   FixedString
    //                                                                       .alter))
    //                                                         ],
    //                                                       )
    //                                                     ],
    //                                                   ),
    //                                                 ),
    //                                               );
    //                                             });
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               );
    //                             });
    //                       },
    //                     ),
    //                   );
    //                 },
    //                 separatorBuilder: (context, index) {
    //                   return const Divider();
    //                 },
    //                 itemCount: _controller.alunos.length);

    //           case AlunoState.loading:
    //             return const CircularProgressIndicator();

    //           case AlunoState.failure:
    //             return const Center(child: Text('Erro'));
    //           case AlunoState.forbidden:
    //             return InkWell(
    //               onTap: () {
    //                 _controller.init();
    //               },
    //               child: Container(
    //                 color: Colors.red,
    //               ),
    //             );
    //         }
    //       }),
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.blue[600],
    //     onPressed: () {
    //       showModalBottomSheet(
    //           isScrollControlled: true,
    //           context: context,
    //           builder: (context) {
    //             final controllerTitle = TextEditingController();
    //             final controllerDescription = TextEditingController();
    //             return Padding(
    //               padding: MediaQuery.of(context).viewInsets,
    //               child: Padding(
    //                 padding: EdgeInsets.symmetric(
    //                   horizontal: PaddingValues.xxvalue,
    //                   vertical: PaddingValues.xxxvalue,
    //                 ),
    //                 child: Wrap(
    //                   children: [
    //                     TextFormField(
    //                       textCapitalization: TextCapitalization.words,
    //                       controller: controllerTitle,
    //                       decoration: InputDecoration(
    //                         hintText: FixedString.course,
    //                         border: const OutlineInputBorder(),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(top: PaddingValues.xxvalue),
    //                       child: TextField(
    //                         inputFormatters: [
    //                           LengthLimitingTextInputFormatter(50),
    //                         ],
    //                         maxLines: 2,
    //                         controller: controllerDescription,
    //                         decoration: InputDecoration(
    //                           hintText: FixedString.descriptionCourse,
    //                           border: const OutlineInputBorder(),
    //                         ),
    //                       ),
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         TextButton(
    //                             onPressed: () {
    //                               Navigator.of(context).pop();
    //                             },
    //                             child: Text(FixedString.cancel)),
    //                         TextButton(
    //                             onPressed: () {
    //                               _controller.post(
    //                                   aluno: AlunoEntity(
    //                                 nome: controllerTitle.text,
    //                               ));
    //                               Navigator.of(context).pop();
    //                             },
    //                             child: Text(FixedString.save))
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             );
    //           });
    //     },
    //     child: const Icon(
    //       Icons.add,
    //       color: Colors.white,
    //     ),
    //   ),
    // );
  }
}
