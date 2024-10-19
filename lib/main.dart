import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:tractian/core/di/di_setup_binding.dart';
import 'package:tractian/core/routes/routes.dart';
import 'package:tractian/features/company/presentation/controllers/home_binding.dart';
import 'package:tractian/utils/log/log_utils.dart';

import 'features/company/presentation/pages/home_page.dart';
import 'utils/theme/app_theme.dart';

Future<void> main() async {
  final log = Logger('[MAIN]');
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    LogUtils.init();
    final setup = DiSetupBinding();
    setup.dependencies();
    await GetStorage.init();
    runApp(const MyApp());
  }, (e, stack) {
    log.severe('Catching exception', e, stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian',
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.route,
      theme: theme,
      getPages: routes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialBinding: HomeBinding(),
      onInit: () async {
        FlutterNativeSplash.remove();
      },
    );
  }
}
