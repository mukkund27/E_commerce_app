import 'dart:async';

import 'package:e_com/logic/cubit/user_cubit/user_cubit.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:e_com/presentation/screens/auth/login_screen.dart';
import 'package:e_com/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;

    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else if (userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
