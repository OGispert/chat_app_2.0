import 'package:chat_app_2/widgets/form_button.dart';
import 'package:chat_app_2/widgets/form_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, this.isRegistering = false});

  final bool isRegistering;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isRegistering)
          CustomFormField(
            fieldLabel: 'Name',
            fieldIcon: Icon(Icons.person_outlined),
            textController: nameController,
          ),
        SizedBox(height: 16),

        CustomFormField(
          fieldLabel: 'Username',
          fieldIcon: Icon(Icons.mail_outline),
          keyboardType: TextInputType.emailAddress,
          textController: usernameController,
        ),
        SizedBox(height: 16),
        CustomFormField(
          fieldLabel: 'Password',
          fieldIcon: Icon(Icons.lock_outline),
          isProtected: true,
          textController: passwordController,
        ),
        CustomFormButton(
          buttonLabel: widget.isRegistering ? 'Register' : 'Sign In',
          onPress: () {},
        ),
      ],
    );
  }
}
