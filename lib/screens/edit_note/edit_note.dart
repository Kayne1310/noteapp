// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_cubit/screens/list_note/cubit/list_note_cubit.dart';
import 'package:flutter_bloc_cubit/screens/list_note/list_note.dart';

class EditNote extends StatelessWidget {
  static const String route = "EditNote";
  final bool isAddMode;

  const EditNote({
  
     this.isAddMode=false,
  }) ;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListNoteCubit, ListNoteState>(
      builder: (context, state) {
        var _title = TextEditingController(text: isAddMode==true ? "": state.notes[state.selectIndex].title );
        var _content = TextEditingController(text: isAddMode==true ? "": state.notes[state.selectIndex].content);
        return Container(
          child: Expanded(
            child: Column(
              children: [
                Text("${isAddMode==true ? "Add" :"Edit"}"),
                TextField(
                  controller: _title,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _content,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      if(isAddMode==false){

                      context.read<ListNoteCubit>().editNote(
                          state.selectIndex, _title.text, _content.text);
                      Navigator.of(context).popUntil(ModalRoute.withName(ListNoteApp.route));
                      //Navigator.of(context).pushName(ListNoteApp.route);

                      }
                      else {
                         context.read<ListNoteCubit>().addNote(
                           _title.text, _content.text);
                         Navigator.of(context).pop();

                      }
                      
                    },
                    child: Text("Save"))
              ],
            ),
          ),
        );
      },
    );
  }
}
