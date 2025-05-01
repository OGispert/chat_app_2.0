import 'package:chat_app_2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
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
    final authService = Provider.of<AuthService>(context);
    final ownUID = authService.user.uid;

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: uuid == ownUID ? sent(uuid == ownUID) : received(uuid == ownUID),
      ),
    );
  }

  Widget sent(bool ownUID) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8, left: 50, right: 8),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.only(
            bottomLeft: !(ownUID) ? Radius.zero : const Radius.circular(12),
            bottomRight: (ownUID) ? Radius.zero : const Radius.circular(12),
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget received(bool ownUID) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 50),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 38, 188, 68),
          borderRadius: BorderRadius.only(
            bottomLeft: !(ownUID) ? Radius.zero : const Radius.circular(12),
            bottomRight: (ownUID) ? Radius.zero : const Radius.circular(12),
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          ),
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
