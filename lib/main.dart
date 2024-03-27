import 'package:e_store/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:e_store/shared/bloc_observer.dart';
import 'package:e_store/shared/cubit/cubit.dart';
import 'package:e_store/shared/cubit/states.dart';
import 'package:e_store/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
