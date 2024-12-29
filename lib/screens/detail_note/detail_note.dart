import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/screens/edit_note/edit_note.dart';
import 'package:flutter_bloc_cubit/screens/list_note/cubit/list_note_cubit.dart';

class DetailNote extends StatelessWidget {
  static const String route = "DetailNote";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListNoteCubit, ListNoteState>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              Text("${state.notes[state.selectIndex].dateTime.toString()}"),
              SizedBox(
                height: 16,
              ),
              Text("${state.notes[state.selectIndex].title}"),
              SizedBox(
                height: 16,
              ),
              Text("${state.notes[state.selectIndex].content}"),
              ElevatedButton(
                  onPressed: () {
                    if(state.pagecount<3){

                    Navigator.of(context).pushNamed(
                      EditNote.route,
                      arguments: {"cubit": context.read<ListNoteCubit>()},
                    );
                    }
                  },
                  child: Text("Edit")),
            ],
          ),
        );
      },
    );
  }
}
