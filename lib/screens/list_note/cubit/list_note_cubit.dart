import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_note_state.dart';

class ListNoteCubit extends Cubit<ListNoteState> {
  ListNoteCubit() : super(ListNoteState()) {
    var newNote = [
      NoteItem(dateTime: DateTime.now(), title: "1", content: "123"),
      NoteItem(dateTime: DateTime.now(), title: "2", content: "321"),
      NoteItem(dateTime: DateTime.now(), title: "3", content: "1234"),
    ];
    emit(state.copyWith(notes: newNote));
  }

  void addNote(String title, String content) {
    var newNote = [
      NoteItem(dateTime: DateTime.now(), title: title, content: content),
      ...state.notes
    ];
    emit(state.copyWith(notes: newNote));
  }

  void removeNote(int index) {
    var newNote = [...state.notes];
    newNote.removeAt(index);
    emit(state.copyWith(notes: newNote));
  }

  void editNote(int index, String title, String content) {
    var newNote = [...state.notes];
    newNote[index] = newNote[index].copyWith(title: title, content: content);
    emit(state.copyWith(notes: newNote));
  }

  void setPageCount(int pagecount) {
    emit(state.copyWith(pagecount: pagecount));
  }

  void setSelectIndex(int selectIndex) {
    emit(state.copyWith(selectIndex: selectIndex));
  }
}
