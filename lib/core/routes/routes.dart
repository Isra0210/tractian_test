import 'package:get/route_manager.dart';
import 'package:tractian/features/assets/presentation/pages/asset_page.dart';
import 'package:tractian/features/location/presentation/controller/location_binding.dart';

import '../../features/assets/presentation/controllers/asset_binding.dart';
import '../../features/company/presentation/pages/home_page.dart';

final routes = [
  GetPage(name: HomePage.route, page: () => const HomePage()),
  GetPage(
    name: AssetPage.route,
    page: () => const AssetPage(),
    binding: AssetBinding(),
    bindings: [LocationBinding()]
  ),
];
