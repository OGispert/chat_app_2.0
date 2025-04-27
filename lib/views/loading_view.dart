import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/views/login_view.dart';
import 'package:chat_app_2/views/users_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(child: CupertinoActivityIndicator(animating: true));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isAuthenticated = await authService.isLoggedId();

    if (isAuthenticated && context.mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => UsersView()),
      );
    } else if (context.mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => LoginView()),
      );
    }
  }
}
