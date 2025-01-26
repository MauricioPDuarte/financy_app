import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/enums/page_state.dart';
import 'package:financy_app/core/domain/usecase.dart';
import 'package:financy_app/core/ui/utils/app_dialogs.dart';
import 'package:financy_app/modules/box/box_routes.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_set_logged_user_usecase.dart';
import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';
import 'package:financy_app/modules/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:financy_app/modules/sign_in/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:financy_app/modules/sign_in/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class SignInController {
  Future<void> signIn();
  Future<void> signInWithFacebook();
  Future<void> signInWithGoogle();

  ValueNotifier<PageState> get signInState;
  GlobalKey<FormState> get formKey;
  bool get signInIsLoading;

  TextEditingController get emailController;
  TextEditingController get passwordController;
}

class SignInControllerImpl implements SignInController {
  final SignInUseCase signInUseCase;
  final SignInWithFacebookUseCase signInWithFacebookUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SharedSetLoggedUserUsecase setLoggedUserUsecase;

  SignInControllerImpl({
    required this.signInUseCase,
    required this.setLoggedUserUsecase,
    required this.signInWithFacebookUseCase,
    required this.signInWithGoogleUseCase,
  });

  @override
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  TextEditingController emailController = TextEditingController();
  @override
  TextEditingController passwordController = TextEditingController();

  @override
  bool get signInIsLoading => signInState.value == PageState.loading;

  @override
  ValueNotifier<PageState> signInState =
      ValueNotifier<PageState>(PageState.initial);

  @override
  Future<void> signIn() async {
    if (formKey.currentState?.validate() == false) return;

    signInState.value = PageState.loading;

    final result = await signInUseCase(RequestSignInEntity(
      email: emailController.text,
      password: passwordController.text,
    ));

    result.fold((failure) {
      signInState.value = PageState.error;
      AppDialogs.bottomSheetError(
          title: 'Ei, algo deu errado!', message: failure.msg);
    }, (data) async {
      bool successSetLoggedUser = await _setLoggedUser(data);

      if (successSetLoggedUser) {
        signInState.value = PageState.success;
        Modular.to.pushNamed(BoxRoutes.listBoxes);
      } else {
        signInState.value = PageState.error;
      }
    });
  }

  @override
  Future<void> signInWithFacebook() async {
    if (formKey.currentState?.validate() == false) return;

    signInState.value = PageState.loading;

    final result = await signInWithFacebookUseCase(NoParams());

    result.fold((failure) {
      signInState.value = PageState.error;
      AppDialogs.bottomSheetError(
          title: 'Ei, algo deu errado!', message: failure.msg);
    }, (data) async {
      bool successSetLoggedUser = await _setLoggedUser(data);

      if (successSetLoggedUser) {
        signInState.value = PageState.success;
        Modular.to.pushNamed(BoxRoutes.listBoxes);
      } else {
        signInState.value = PageState.error;
      }
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    if (formKey.currentState?.validate() == false) return;

    signInState.value = PageState.loading;

    final result = await signInWithGoogleUseCase(NoParams());

    result.fold((failure) {
      signInState.value = PageState.error;
      AppDialogs.bottomSheetError(
          title: 'Ei, algo deu errado!', message: failure.msg);
    }, (data) async {
      bool successSetLoggedUser = await _setLoggedUser(data);

      if (successSetLoggedUser) {
        signInState.value = PageState.success;
        Modular.to.pushNamed(BoxRoutes.listBoxes);
      } else {
        signInState.value = PageState.error;
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
