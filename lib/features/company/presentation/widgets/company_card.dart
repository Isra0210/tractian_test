import 'package:flutter/material.dart';
import 'package:tractian/utils/icons/app_icons.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({required this.name, this.onTap, super.key});

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 24, left: 22, right: 22),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        height: 67,
        width: 317,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Image.asset(AppIcons.company, width: 24, height: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
