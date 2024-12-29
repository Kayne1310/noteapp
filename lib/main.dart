import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/route.dart';
import 'package:flutter_bloc_cubit/screens/login/login.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse
        }
      ),
      home: SafeArea(
        child: Scaffold(),
      ),
      onGenerateRoute: MainRoute,
      initialRoute: LoginPage.route,
    );
  }


 
}

//lang nghe khi cac cubit thay doi

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
