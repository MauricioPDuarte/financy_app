import 'package:financy_app/core/core_module.dart';
import 'package:financy_app/modules/shared/data/datasouces/impl/shared_local_datasource_impl.dart';
import 'package:financy_app/modules/shared/data/datasouces/impl/shared_remote_datasource_impl.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_remote_datasource.dart';
import 'package:financy_app/modules/shared/data/repositories/shared_local_repository_impl.dart';
import 'package:financy_app/modules/shared/data/repositories/shared_remote_repository_impl.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_remote_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_get_logged_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_logout_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_set_logged_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_sign_in_with_facebook_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_sign_in_with_google_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SharedModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {
    // Datasource
    i.addLazySingleton<SharedLocalDatasource>(SharedLocalDatasourceImpl.new);
    i.addLazySingleton<SharedRemoteDatasource>(SharedRemoteDatasourceImpl.new);

    // Repositories
    i.addLazySingleton<SharedLocalRepository>(SharedLocalRepositoryImpl.new);
    i.addLazySingleton<SharedRemoteRepository>(SharedRemoteRepositoryImpl.new);

    // UseCases
    i.addLazySingleton<SharedSetLoggedUserUsecase>(
        SharedSetLoggedUserUsecaseImpl.new);
    i.addLazySingleton<SharedGetLoggedUserUsecase>(
        SharedGetLoggedUserUsecaseImpl.new);
    i.addLazySingleton<SharedLogoutUserUsecase>(
        SharedLogoutUserUsecaseImpl.new);
    i.addLazySingleton<SharedSignInWithFacebookUseCase>(
        SharedSignInWithFacebookUseCaseImpl.new);
    i.addLazySingleton<SharedSignInWithGoogleUseCase>(
        SharedSignInWithGoogleUseCaseImpl.new);

    super.exportedBinds(i);
  }
}
