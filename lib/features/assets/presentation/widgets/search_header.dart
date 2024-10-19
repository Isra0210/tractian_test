import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:tractian/features/assets/domain/entities/tree_node_entity.dart';
import 'package:tractian/features/assets/presentation/controllers/assets_controller.dart';
import 'package:tractian/utils/icons/app_icons.dart';

import '../../../../utils/widgets/button_with_icon.dart';

class SearchHeader extends GetView<AssetController> {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final str = AppLocalizations.of(context)!;
    final searchField = SizedBox(
      height: 42,
      child: TextField(
        cursorHeight: 14,
        style: theme.textTheme.labelMedium!.copyWith(
          color: theme.colorScheme.surface,
        ),
        decoration: InputDecoration(
          hintText: str.searchBy,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset(AppIcons.search, height: 14, width: 14)],
          ),
        ),
        onChanged: (value) => controller.search = value,
      ),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              searchField,
              const SizedBox(height: 8),
              Obx(() {
                return Row(
                  children: [
                    ButtonWithIcon(
                      label: str.energySensor,
                      icon: AppIcons.boltOutlined,
                      isActived: controller.filter == NodeStatus.operating,
                      onTap: () {
                        if (controller.filter == NodeStatus.operating) {
                          controller.filter = NodeStatus.none;
                        } else {
                          controller.filter = NodeStatus.operating;
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    ButtonWithIcon(
                      label: str.critical,
                      icon: AppIcons.info,
                      isActived: controller.filter == NodeStatus.alert,
                      onTap: () {
                        if (controller.filter == NodeStatus.alert) {
                          controller.filter = NodeStatus.none;
                        } else {
                          controller.filter = NodeStatus.alert;
                        }
                      },
                    )
                  ],
                );
              }),
            ],
          ),
        ),
        Divider(color: theme.colorScheme.secondary),
      ],
    );
  }
}
