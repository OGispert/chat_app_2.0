import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    required this.uuid,
    required this.animationController,
  });

  final String message;
  final String uuid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: uuid == 'own' ? sent() : received(),
      ),
    );
  }

  Widget sent() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8, left: 50, right: 8),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.only(
            bottomLeft:
                !(uuid == 'own') ? Radius.zero : const Radius.circular(12),
            bottomRight:
                (uuid == 'own') ? Radius.zero : const Radius.circular(12),
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget received() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 50),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 38, 188, 68),
          borderRadius: BorderRadius.only(
            bottomLeft:
                !(uuid == 'own') ? Radius.zero : const Radius.circular(12),
            bottomRight:
                (uuid == 'own') ? Radius.zero : const Radius.circular(12),
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
