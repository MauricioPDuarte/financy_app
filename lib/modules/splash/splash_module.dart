import 'package:financy_app/core/base_module.dart';
import 'package:financy_app/modules/splash/presentation/controllers/splash_controller.dart';
import 'package:financy_app/modules/splash/presentation/pages/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends BaseModule {
  @override
  void binds(i) {
    // Controllers
    i.add<SplashController>(() => SplashControllerImpl(
          getLoggedUserUsecase: i.get(),
        ));
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => SplashPage());
  }
}
