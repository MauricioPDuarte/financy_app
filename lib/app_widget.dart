import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppGlobalKeys {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final globalKey = GlobalKey();
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    Modular.setNavigatorKey(AppGlobalKeys.navigatorKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: AppGlobalKeys.globalKey,
      title: 'Financy App',
      scaffoldMessengerKey: AppGlobalKeys.scaffoldMessengerKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    );
  }
}
