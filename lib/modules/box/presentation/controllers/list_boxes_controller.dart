import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/onboarding/onboarding_routes.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_logout_user_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ListBoxesController {
  Future<void> logout();
}

class ListBoxesControllerImpl implements ListBoxesController {
  final SharedLogoutUserUsecase logoutUserUsecase;

  ListBoxesControllerImpl({required this.logoutUserUsecase});

  @override
  Future<void> logout() async {
    final result = await logoutUserUsecase(NoParams());

    result.fold((_) {}, (_) {
      Modular.to.pushReplacementNamed(OnboardingRoutes.onboarding);
    });
  }
}
