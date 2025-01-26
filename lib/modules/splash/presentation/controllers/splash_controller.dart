import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/modules/box/box_routes.dart';
import 'package:financy_app/modules/onboarding/onboarding_routes.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_get_logged_user_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class SplashController {
  Future<void> init();
}

class SplashControllerImpl implements SplashController {
  final SharedGetLoggedUserUsecase getLoggedUserUsecase;

  SplashControllerImpl({required this.getLoggedUserUsecase});

  @override
  Future<void> init() async {
    final result = await getLoggedUserUsecase(NoParams());

    UserEntity? user = result.fold((failure) => null, (data) => data);

    await Future.delayed(const Duration(seconds: 3));

    if (user != null) {
      Modular.to.pushReplacementNamed(BoxRoutes.listBoxes);
    } else {
      Modular.to.pushReplacementNamed(OnboardingRoutes.onboarding);
    }
  }
}
