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
                    FocusScope.of(context).unfocus();
                    if (widget.isRegistering) {
                      final registered = await authService.register(
                        nameController.text.trim(),
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (registered && context.mounted) {
                        nameController.clear();
                        usernameController.clear();
                        passwordController.clear();
                        showCustomAlert(
                          context,
                          'Register success!',
                          'Please login with your new credentials.',
                        );
                      } else if (context.mounted) {
                        showCustomAlert(
                          context,
                          'Register error!',
                          'Please try again.',
                        );
                      }
                    } else {
                      final loggedIn = await authService.login(
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (loggedIn && context.mounted) {
                        // ToDo - Connect socket server
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => UsersView(),
                          ),
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
