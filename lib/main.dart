import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:razinsoft_task_management/config/hive_constants.dart';
import 'package:razinsoft_task_management/core/routes/app_router.dart';
import 'package:razinsoft_task_management/core/routes/app_routes.dart';
import 'core/config/theme.dart';
import 'core/utils/global_function.dart';
import 'core/widgets/connectivity_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';import 'package:connectivity_wrapper/connectivity_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveConstants.authBox);
  await Hive.openBox(HiveConstants.userBox);
  await Hive.openBox(HiveConstants.appSettingsBox);
  runApp(
      const ProviderScope(
        child: GlobalConnectivityWrapper(child: MyApp()),
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Locale resolveLocal({required String langCode}) {
    return Locale(langCode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // _listenToFirebaseMessaging(ref: ref);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 800), // XD Design Sizes
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(HiveConstants.appSettingsBox).listenable(),
          builder: (context, appSettingsBox, _) {
            final isDark = appSettingsBox.get(HiveConstants.isDarkMode, defaultValue: false) as bool;
            return ConnectivityAppWrapper(
              app: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: ApGlobalFunctions.navigatorKey,
                scaffoldMessengerKey: ApGlobalFunctions.getSnackbarKey(),
                title: 'Task Management',
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                theme: getAppTheme(
                  context: context,
                  isDarkTheme: false,
                ),
                darkTheme: getAppTheme(
                  context: context,
                  isDarkTheme: true,
                ),
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: AppRoutes.splashScreen,
                builder: EasyLoading.init(),
              ),
            );
          },
        );
      },
    );
  }
}

