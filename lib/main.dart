import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shered_prefrences.dart';
import 'package:se7ety/core/utils/theme.dart';
import 'package:se7ety/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('ar'),
      child: DevicePreview(enabled: kDebugMode, builder: (context) => const MainApp()),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: Routes.route, debugShowCheckedModeBanner: false, theme: AppTheme.lightTheme, localizationsDelegates: context.localizationDelegates, supportedLocales: context.supportedLocales, locale: context.locale);
  }
}
