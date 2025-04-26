import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  const CustomFormButton({
    super.key,
    required this.buttonLabel,
    required this.onPress,
  });

  final String buttonLabel;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(5),
          backgroundColor: WidgetStatePropertyAll(
            onPress == null ? Colors.black26 : Colors.blue,
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        onPressed: onPress,
        child: Center(
          widthFactor: double.infinity,
          heightFactor: 2.5,
          child: Text(
            buttonLabel,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
