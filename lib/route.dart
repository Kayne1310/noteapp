import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/screens/detail_note/detail_note.dart';
import 'package:flutter_bloc_cubit/screens/edit_note/edit_note.dart';
import 'package:flutter_bloc_cubit/screens/list_note/cubit/list_note_cubit.dart';
import 'package:flutter_bloc_cubit/screens/list_note/list_note.dart';
import 'package:flutter_bloc_cubit/screens/login/login.dart';

Route<dynamic>? MainRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.route:
      return MaterialPageRoute(builder: (context) => LoginPage());
    //edit note
    case EditNote.route:
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit']
          as ListNoteCubit;
      var isAddMode = false;
      if ((settings.arguments as Map<String, dynamic>)['isAddMode'] != null) {
        isAddMode =
            (settings.arguments as Map<String, dynamic>)['isAddMode'] as bool;
      }
      return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: cubit,
                child: Scaffold(body: EditNote(isAddMode: isAddMode)),
              ));
    case ListNoteApp.route:
      return MaterialPageRoute(
        builder: (context) => ListNoteApp(),
        settings: RouteSettings(name: ListNoteApp.route),
      );
    case DetailNote.route:
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit']
          as ListNoteCubit;
      return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: cubit,
                child: Scaffold(
                  body: DetailNote(),
                ),
              ));

    default:
      return MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
  }
}
