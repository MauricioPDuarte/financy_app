import 'package:financy_app/core/code_module.dart';
import 'package:financy_app/modules/shared/data/datasouces/impl/shared_local_datasource_impl.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';
import 'package:financy_app/modules/shared/data/repositories/shared_local_repository_impl.dart';
import 'package:financy_app/modules/shared/domain/repositories/shared_local_repository.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_get_logged_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_logout_user_usecase.dart';
import 'package:financy_app/modules/shared/domain/usecases/shared_set_logged_user_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SharedModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    // Datasource
    i.addLazySingleton<SharedLocalDatasource>(
        () => SharedLocalDatasourceImpl(sessionService: i.get()));

    // Repositories
    i.addLazySingleton<SharedLocalRepository>(
        () => SharedLocalRepositoryImpl(datasource: i.get()));

    // UseCases
    i.addLazySingleton<SharedSetLoggedUserUsecase>(
        () => SharedSetLoggedUserUsecaseImpl(repository: i.get()));
    i.addLazySingleton<SharedGetLoggedUserUsecase>(
        () => SharedGetLoggedUserUsecaseImpl(repository: i.get()));
    i.addLazySingleton<SharedLogoutUserUsecase>(
        () => SharedLogoutUserUsecaseImpl(repository: i.get()));
  }
}
