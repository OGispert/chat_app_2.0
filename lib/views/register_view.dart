import 'package:chat_app_2/widgets/form.dart';
import 'package:chat_app_2/widgets/switcher.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              CustomForm(isRegistering: true),
              SizedBox(height: 24),
              Switcher(title: 'Already have an account?', buttonLabel: 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
