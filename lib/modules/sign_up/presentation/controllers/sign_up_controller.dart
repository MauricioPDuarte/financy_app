import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/enums/page_state.dart';
import 'package:financy_app/core/ui/utils/app_dialogs.dart';
import 'package:financy_app/modules/box/box_routes.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_set_logged_user_usecase.dart';
import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';
import 'package:financy_app/modules/sign_up/domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class SignUpController {
  GlobalKey<FormState> get formKey;
  TextEditingController get passwordController;
  TextEditingController get emailController;

  ValueNotifier<PageState> get signUpState;
  bool get signUpIsLoading;

  Future<void> doSignUp();
}

class SignUpControllerImpl implements SignUpController {
  final SignUpUseCase signUpUseCase;
  final SharedSetLoggedUserUsecase setLoggedUserUsecase;

  SignUpControllerImpl({
    required this.signUpUseCase,
    required this.setLoggedUserUsecase,
  });

  @override
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  TextEditingController passwordController = TextEditingController();
  @override
  TextEditingController emailController = TextEditingController();

  @override
  ValueNotifier<PageState> signUpState =
      ValueNotifier<PageState>(PageState.initial);

  @override
  bool get signUpIsLoading => signUpState.value == PageState.loading;

  @override
  Future<void> doSignUp() async {
    if (formKey.currentState?.validate() == false) return;

    signUpState.value = PageState.loading;

    final result = await signUpUseCase(RequestSignUpEntity(
        email: emailController.text, password: passwordController.text));

    result.fold((failure) {
      signUpState.value = PageState.error;
      AppDialogs.bottomSheetError(
          title: 'Ei, algo deu errado!', message: failure.msg);
    }, (data) async {
      bool successSetLoggedUser = await _setLoggedUser(data);

      if (successSetLoggedUser) {
        signUpState.value = PageState.success;
        Modular.to.pushReplacementNamed(BoxRoutes.listBoxes);
      } else {
        signUpState.value = PageState.error;
      }
    });
  }

  Future<bool> _setLoggedUser(UserEntity user) async {
    final result = await setLoggedUserUsecase(user);

    return result.fold((failure) {
      AppDialogs.bottomSheetError(
          title: 'Ei, algo deu errado!', message: failure.msg);
      return false;
    }, (success) => success);
  }
}
