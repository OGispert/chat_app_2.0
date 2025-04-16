import 'package:chat_app_2/widgets/form.dart';
import 'package:chat_app_2/widgets/logo.dart';
import 'package:chat_app_2/widgets/switcher.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Logo(),
              SizedBox(height: 24),
              CustomForm(),
              SizedBox(height: 24),
              Switcher(
                title: 'Don\'t have an account?',
                buttonLabel: 'Register',
              ),
              SizedBox(height: 100),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
