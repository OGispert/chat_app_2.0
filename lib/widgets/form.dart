import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/views/users_view.dart';
import 'package:chat_app_2/widgets/alerts.dart';
import 'package:chat_app_2/widgets/form_button.dart';
import 'package:chat_app_2/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);

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
          fieldLabel: 'Username (email)',
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
          onPress:
              authService.authenticating
                  ? null
                  : () async {
                    if (widget.isRegistering) {
                    } else {
                      FocusScope.of(context).unfocus();
                      final loggedIn = await authService.login(
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (loggedIn && context.mounted) {
                        // ToDo - Connect socket server
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => UsersView()),
                        );
                      } else if (context.mounted) {
                        showCustomAlert(
                          context,
                          'Login error!',
                          'Please check your credentials and try again.',
                        );
                      }
                    }
                  },
        ),
      ],
    );
  }
}
