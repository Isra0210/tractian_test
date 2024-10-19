import 'package:flutter/material.dart';

class StatusErrorWidget extends StatelessWidget {
  const StatusErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 6,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }
}
