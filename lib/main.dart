import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/socket_service.dart';
import 'package:chat_app_2/views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => SocketService()),
      ],
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 46, 97, 110),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: LoadingView(),
      ),
    );
  }
}
