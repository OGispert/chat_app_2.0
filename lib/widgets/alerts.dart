import 'package:flutter/material.dart';

showCustomAlert(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
  );
}
