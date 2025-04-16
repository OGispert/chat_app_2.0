import 'package:chat_app_2/views/register_view.dart';
import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  const Switcher({super.key, required this.title, required this.buttonLabel});

  final String title;
  final String buttonLabel;

  void openRegister(BuildContext context) {
    showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => RegisterView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.black45)),
          TextButton(
            onPressed: () {
              if (buttonLabel == 'Register') {
                openRegister(context);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              buttonLabel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
