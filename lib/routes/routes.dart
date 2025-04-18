import 'package:chat_app_2/views/chat_view.dart';
import 'package:chat_app_2/views/loading_view.dart';
import 'package:chat_app_2/views/login_view.dart';
import 'package:chat_app_2/views/register_view.dart';
import 'package:chat_app_2/views/users_view.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => UsersView(),
  'chat': (_) => ChatView(userName: ''),
  'register': (_) => RegisterView(),
  'login': (_) => LoginView(),
  'loading': (_) => LoadingView(),
};
