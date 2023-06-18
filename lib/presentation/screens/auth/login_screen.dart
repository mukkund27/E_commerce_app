import 'package:e_com/logic/cubit/user_cubit/user_cubit.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:e_com/presentation/screens/auth/provider/login_provider.dart';
import 'package:e_com/presentation/screens/auth/signup_screen.dart';
import 'package:e_com/presentation/screens/home/home_screen.dart';
import 'package:e_com/presentation/widgets/gap_widget.dart';
import 'package:e_com/presentation/widgets/link_button.dart';
import 'package:e_com/presentation/widgets/primary_button.dart';
import 'package:e_com/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit,UserState>(
      listener: (context, state) {
        if(state is UserLoggedInState ){
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Ecommerce App",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Login",
                  style: TextStyles.heading2,
                ),
                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const GapWidget(),
                PrimaryTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address is Required!";
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                  controller: provider.emailController,
                  labelText: 'Email Address',
                ),
                const GapWidget(),
                PrimaryTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is Required!";
                    }
                    if(value.length<6){
                      return "Password is minimum 6 digits!";
                    }
                    return null;
                  },
                  controller: provider.passwordController,
                  obscureText: true,
                  labelText: 'Password',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkButton(
                      text: "Forget Password?",
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                  onPressed: provider.login,
                  text: (provider.isLoading) ? "..." : "Log In",
                ),
                const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?  ",
                      style: TextStyle(fontSize: 16),
                    ),
                    LinkButton(onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    }, text: 'Sign Up'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
