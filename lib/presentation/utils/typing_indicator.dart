import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  final bool isTyping;

  TypingIndicator({required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return isTyping
        ? Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
              SizedBox(width: 8),
              Text(
                "Typing...",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        : Container();
  }
}
