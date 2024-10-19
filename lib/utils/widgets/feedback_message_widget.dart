import 'package:flutter/material.dart';

class FeedbackMessageWidget extends StatelessWidget {
  const FeedbackMessageWidget(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
