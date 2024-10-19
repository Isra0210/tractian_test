import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:tractian/features/assets/presentation/pages/asset_page.dart';
import 'package:tractian/features/company/presentation/controllers/home_controller.dart';
import 'package:tractian/features/company/presentation/widgets/company_card.dart';
import 'package:tractian/utils/constants/constants.dart';
import 'package:tractian/utils/icons/app_icons.dart';
import 'package:tractian/utils/navigator/app_navigator.dart';

import '../../../../utils/widgets/loading_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    final appBar = AppBar(title: Image.asset(AppIcons.logo, width: 126));
    final errorMessage = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(controller.errorMessage, style: textStyle),
      ),
    );
    final emptyCompaniesMessage = Center(
      child: Text(str.noCompaniesToShow, style: textStyle),
    );

    return Scaffold(
      appBar: appBar,
      body: Obx(() {
        if (controller.isLoading) return const LoadingWidget();
        if (controller.errorMessage.isNotEmpty) return errorMessage;
        if (controller.companies.isEmpty) return emptyCompaniesMessage;

        return ListView.builder(
          itemCount: controller.companies.length,
          itemBuilder: (context, index) {
            final company = controller.companies[index];
            return CompanyCard(
              name: company.name,
              onTap: () {
                AppNavigator.of(context).toNamed(AssetPage.route,
                    arguments: company.id, parameters: {kId: company.id});
              },
            );
          },
        );
      }),
    );
  }
}
