import 'package:e_com/presentation/screens/auth/provider/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName="signup";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<SignUpProvider>(context);
    return Scaffold(
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
                "Create Account ",
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
              const GapWidget(),
              PrimaryTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your Password!";
                  }
                  if(value.trim() != provider.passwordController.text.trim()){
                    return "Passwords do not match!";
                  }
                  return null;
                },
                controller: provider.cPasswordController,
                obscureText: true,
                labelText: 'Confirm Password',
              ),

              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                onPressed: provider.createAccount,
                text: (provider.isLoading) ? "..." : "Create Account",
              ),
              const GapWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?  ",
                    style: TextStyle(fontSize: 16),
                  ),
                  LinkButton(onPressed: () {}, text: 'Log In'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

