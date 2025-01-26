import 'package:financy_app/core/data/models/user_model.dart';

abstract class SharedLocalDatasource {
  Future<bool> setLoggedUser(UserModel user);
  Future<UserModel?> getLoggedUser();
  Future<bool> doLogout();
}
