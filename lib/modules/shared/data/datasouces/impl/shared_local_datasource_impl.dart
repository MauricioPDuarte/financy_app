import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/session_service.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_local_datasource.dart';

class SharedLocalDatasourceImpl implements SharedLocalDatasource {
  final SessionService sessionService;

  SharedLocalDatasourceImpl({required this.sessionService});

  @override
  Future<bool> doLogout() async {
    return await sessionService.destroyLoggedUser();
  }

  @override
  Future<UserModel?> getLoggedUser() async {
    return await sessionService.getLoggedUser();
  }

  @override
  Future<bool> setLoggedUser(UserModel user) async {
    return await sessionService.setLoggedUser(user);
  }
}
