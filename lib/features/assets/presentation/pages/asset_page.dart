import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:tractian/features/assets/presentation/controllers/assets_controller.dart';
import 'package:tractian/features/assets/presentation/widgets/search_header.dart';
import 'package:tractian/utils/constants/constants.dart';
import 'package:tractian/utils/icons/app_icons.dart';
import 'package:tractian/utils/theme/app_colors.dart';
import 'package:tractian/utils/widgets/feedback_message_widget.dart';
import 'package:tractian/utils/widgets/loading_widget.dart';
import 'package:tractian/utils/widgets/status_error_widget.dart';
import '../../domain/entities/node_entity.dart';

class AssetPage extends GetView<AssetController> {
  const AssetPage({super.key});

  static const route = '/assets';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final str = AppLocalizations.of(context)!;
    final companyId = Get.parameters[kId];
    const spacing = SizedBox(width: 8);
    final chevronDown = Image.asset(
      AppIcons.chevronDown,
      height: 24,
      width: 24,
    );
    final locationIcon = Image.asset(AppIcons.location, height: 22, width: 22);
    final cubeSmallIcon = Image.asset(
      AppIcons.cubeSmall,
      height: 22,
      width: 22,
    );
    final cube = Image.asset(AppIcons.cube, height: 22, width: 22);
    final operatingSensorComponent = Image.asset(
      AppIcons.boltFilled,
      height: 12,
      width: 9,
    );
    const alertStatusComponent = StatusErrorWidget();

    Widget buildIcon(NodeEntity node) {
      if (node.type == NodeType.location || node.type == NodeType.subLocation) {
        return locationIcon;
      }
      if (node.type == NodeType.location) return locationIcon;
      if (node.type == NodeType.component && node.nodes.isEmpty) {
        return cubeSmallIcon;
      }

      return cube;
    }

    Widget buildStatusIcon(NodeEntity node) => switch (node.status) {
          NodeStatus.alert => alertStatusComponent,
          NodeStatus.operating => operatingSensorComponent,
          _ => const SizedBox(),
        };

    Widget buildTreeNode(NodeEntity node) {
      final title = Row(
        children: [
          buildIcon(node),
          spacing,
          Flexible(
            child: Text(
              node.name,
              style: theme.textTheme.labelMedium!.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
          ),
          spacing,
          buildStatusIcon(node),
        ],
      );

      if (node.nodes.isEmpty) return ListTile(title: title);

      return CustomPaint(
        painter: CreateLine(),
        child: ExpansionTile(
          title: title,
          trailing: const SizedBox(),
          leading: chevronDown,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          initiallyExpanded: true,
          children: node.nodes
              .map(
                (child) => Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: buildTreeNode(child),
                ),
              )
              .toList(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Assets')),
      body: Column(
        children: [
          const SearchHeader(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 16),
              child: FutureBuilder(
                future: controller.fetchAssets(companyId!),
                builder: (context, snapshot) {
                  return Obx(
                    () {
                      if (controller.isLoading) return const LoadingWidget();
                      if (controller.errorMessage.isNotEmpty) {
                        return FeedbackMessageWidget(controller.errorMessage);
                      }
                      if (controller.nodesFiltered.isEmpty) {
                        return FeedbackMessageWidget(str.noAssetsToShow);
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.nodesFiltered.length,
                        itemBuilder: (context, index) {
                          return buildTreeNode(controller.nodesFiltered[index]);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CreateLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = size.topLeft(const Offset(28, 42));
    final p2 = Offset(28, size.height);
    final paint = Paint()
      ..color = AppColors.grey200
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
