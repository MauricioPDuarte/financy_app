import 'package:financy_app/modules/onboarding/onboarding_routes.dart';
import 'package:financy_app/modules/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingModule extends Module {
  @override
  void routes(r) {
    r.child(OnboardingRoutes.onboarding, child: (context) => OnboardingPage());
    super.routes(r);
  }
}
