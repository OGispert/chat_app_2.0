import 'package:chat_app_2/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 46, 97, 110),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: 'users',
      routes: appRoutes,
    );
  }
}
