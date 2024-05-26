import 'package:e_store/modules/login_screen/login_screen.dart';
import 'package:e_store/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:e_store/modules/shop_layout/cubit/cubit.dart';
import 'package:e_store/modules/shop_layout/layout_screen.dart';
import 'package:e_store/shared/bloc_observer.dart';
import 'package:e_store/shared/components/constants.dart';
import 'package:e_store/shared/cubit/cubit.dart';
import 'package:e_store/shared/cubit/states.dart';
import 'package:e_store/shared/network/local/cache_helper.dart';
import 'package:e_store/shared/network/remote/dio_helper.dart';
import 'package:e_store/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  debugPrint(token);

  if (onBoarding != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = const LayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.startWidget,
  });

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
