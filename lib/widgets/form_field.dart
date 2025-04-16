import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.fieldLabel,
    required this.fieldIcon,
    this.keyboardType = TextInputType.text,
    this.isProtected = false,
    required this.textController,
  });

  final String fieldLabel;
  final Icon fieldIcon;
  final TextInputType keyboardType;
  final bool isProtected;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            offset: Offset(0, 0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextFormField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isProtected,
        decoration: InputDecoration(
          prefixIcon: fieldIcon,
          labelText: fieldLabel,
          border: InputBorder.none,
        ),
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
