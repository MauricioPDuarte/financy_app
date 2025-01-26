import 'package:financy_app/core/base_module.dart';
import 'package:financy_app/modules/sign_in/data/datasources/impl/sign_in_datasource_impl.dart';
import 'package:financy_app/modules/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:financy_app/modules/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:financy_app/modules/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:financy_app/modules/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:financy_app/modules/sign_in/presentation/controllers/sign_in_controller.dart';
import 'package:financy_app/modules/sign_in/presentation/pages/sign_in_page.dart';
import 'package:financy_app/modules/sign_in/sign_in_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInModule extends BaseModule {
  @override
  void binds(i) {
    // Datasource
    i.addLazySingleton<SignInDatasource>(
        () => SignInDatasourceImpl(authService: i.get()));

    // Repositories
    i.addLazySingleton<SignInRepository>(
        () => SignInRepositoryImpl(datasource: i.get(), networkInfo: i.get()));

    // UseCases
    i.addLazySingleton<SignInUseCase>(
        () => SignInUseCaseImpl(repository: i.get()));

    // Controllers
    i.add<SignInController>(() => SignInControllerImpl(
          signInUseCase: i.get(),
          setLoggedUserUsecase: i.get(),
        ));
  }

  @override
  void routes(r) {
    r.child(SignInRoutes.signIn, child: (context) => SignInPage());
  }
}
