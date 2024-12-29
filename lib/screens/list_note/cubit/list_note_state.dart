// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_note_cubit.dart';

class ListNoteState extends Equatable {
  final List<NoteItem> notes;
  final int selectIndex;
  final int pagecount;

  ListNoteState({
    this.notes = const [],
    this.selectIndex = 0,
    this.pagecount = 1,
  });

  @override
  List<Object> get props => [notes,selectIndex,pagecount];

  ListNoteState copyWith({
    List<NoteItem>? notes,
    int? selectIndex,
    int? pagecount,
  }) {
    return ListNoteState(
      notes: notes ?? this.notes,
      selectIndex: selectIndex ?? this.selectIndex,
      pagecount: pagecount ?? this.pagecount,
    );
  }
}


class NoteItem extends Equatable {
  final DateTime dateTime;
  final String title;
  final String content;

  NoteItem(
      {required this.dateTime, required this.title, required this.content});

  // coppyWith no trong dart thi no giong nhu constructor thu 2 nhung neu ko gan gia tri cho attribute thi mac dinh la null

  NoteItem copyWith({
    DateTime? dateTime,
    String? title,
    String? content,
  }) {
    return NoteItem(
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [dateTime, title, content];
}
