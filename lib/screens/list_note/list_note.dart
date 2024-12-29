import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/screens/detail_note/detail_note.dart';
import 'package:flutter_bloc_cubit/screens/edit_note/edit_note.dart';
import 'package:flutter_bloc_cubit/screens/list_note/cubit/list_note_cubit.dart';

class ListNoteApp extends StatelessWidget {
  static const String route = "ListNote";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListNoteCubit(),
      child: ListNote(),
    );
  }
}

class ListNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    int pagecount = 0;
    if (width <= 600)
      pagecount = 1;
    else if (width <= 900)
      pagecount = 2;
    else
      pagecount = 3;
    context.read<ListNoteCubit>().setPageCount(pagecount);
    return Scaffold(
      body: switch (pagecount) {
        == 1 => ListNoteScreen(),
        == 2 => ListNoteWithDetail(),
        == 3 => ListNoteDetailEdit(),
        _ => ListNoteScreen(),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EditNote.route, arguments: {
            'cubit': context.read<ListNoteCubit>(),
            'isAddMode': true,
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListNoteScreen extends StatefulWidget {
  @override
  State<ListNoteScreen> createState() => _ListNoteScreenState();
}

class _ListNoteScreenState extends State<ListNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListNoteCubit, ListNoteState>(
      builder: (context, state) {
        return Container(
          child: Expanded(
            child: ListView.builder(
              itemBuilder: (context, int index) {
                var item = state.notes[index];
                return Card(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.dateTime.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<ListNoteCubit>().removeNote(index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    onTap: () {
                      context.read<ListNoteCubit>().setSelectIndex(index);
                      if (state.pagecount == 1) {
                        Navigator.of(context).pushNamed(DetailNote.route,
                            arguments: {
                              "cubit": context.read<ListNoteCubit>()
                            });
                      }
                    },
                  ),
                );
              },
              itemCount: state.notes.length,
            ),
          ),
        );
      },
    );
  }
}

//pagecount ==2 2 page

class ListNoteWithDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListNoteScreen(),
        DetailNote(),
      ],
    );
  }
}

//pagecount ==3 3 page

class ListNoteDetailEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListNoteScreen(),
        ),
        Expanded(
          child: DetailNote(),
        ),
        Expanded(
          child: EditNote(),
        ),
      ],
    );
  }
}
