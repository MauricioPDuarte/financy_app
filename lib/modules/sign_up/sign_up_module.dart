import 'package:financy_app/core/base_module.dart';
import 'package:financy_app/modules/sign_up/data/datasources/impl/sign_up_datasource_impl.dart';
import 'package:financy_app/modules/sign_up/data/datasources/sign_up_datasource.dart';
import 'package:financy_app/modules/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:financy_app/modules/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:financy_app/modules/sign_up/domain/usecases/sign_up_usecase.dart';
import 'package:financy_app/modules/sign_up/presentation/controllers/sign_up_controller.dart';
import 'package:financy_app/modules/sign_up/presentation/pages/sign_up_page.dart';
import 'package:financy_app/modules/sign_up/sign_up_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpModule extends BaseModule {
  @override
  void binds(i) {
    // Datasource
    i.addLazySingleton<SignUpDatasource>(SignUpDatasourceImpl.new);

    // Repositories
    i.addLazySingleton<SignUpRepository>(SignUpRepositoryImpl.new);

    // UseCases
    i.addLazySingleton<SignUpUseCase>(SignUpUseCaseImpl.new);

    // Controllers
    i.add<SignUpController>(SignUpControllerImpl.new);

    super.binds(i);
  }

  @override
  void routes(r) {
    r.child(SignUpRoutes.signUp, child: (context) => SignUpPage());
    super.routes(r);
  }
}
