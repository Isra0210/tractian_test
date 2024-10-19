import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    required this.label,
    required this.icon,
    this.isActived = false,
    this.onTap,
    super.key,
  });

  final String label;
  final void Function()? onTap;
  final String icon;
  final bool isActived;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActived
              ? theme.colorScheme.onPrimary
              : theme.scaffoldBackgroundColor,
          border: Border.all(
            color: isActived
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 16,
              width: 16,
              color: isActived
                  ? theme.scaffoldBackgroundColor
                  : theme.colorScheme.onSurface,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: isActived
                    ? theme.scaffoldBackgroundColor
                    : theme.colorScheme.onSurface,
              ),
            )
          ],
        ),
      ),
    );
  }
}
