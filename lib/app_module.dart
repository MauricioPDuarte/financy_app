import 'package:financy_app/modules/box/box_module.dart';
import 'package:financy_app/modules/onboarding/onboarding_module.dart';
import 'package:financy_app/modules/sign_in/sign_in_module.dart';
import 'package:financy_app/modules/sign_up/sign_up_module.dart';
import 'package:financy_app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: SplashModule());
    r.module(Modular.initialRoute, module: OnboardingModule());
    r.module(Modular.initialRoute, module: SignInModule());
    r.module(Modular.initialRoute, module: SignUpModule());
    r.module(Modular.initialRoute, module: BoxModule());
  }
}
