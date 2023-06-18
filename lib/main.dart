import 'dart:developer';

import 'package:e_com/logic/cubit/category_cubit/category_cubit.dart';
import 'package:e_com/logic/cubit/product_cubit/product_cubit.dart';
import 'package:e_com/logic/cubit/user_cubit/user_cubit.dart';
import 'package:e_com/presentation/screens/auth/login_screen.dart';
import 'package:e_com/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes.dart';
import 'core/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),

        ),
        BlocProvider(
          create: (context) => CategoryCubit(),

        ),
        BlocProvider(
          create: (context) => ProductCubit(),

        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.defaultTheme,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver{

  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
        super.onChange(bloc, change);
  }
  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}
