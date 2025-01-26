import 'package:financy_app/app_widget.dart';
import 'package:financy_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  const Utils();

  /// Setup dependencies and returns [App] widget.
  /// Usually called in [setUp] method within main test.
  Future<Widget> createAppUnderTest() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return const AppWidget();
  }
}
