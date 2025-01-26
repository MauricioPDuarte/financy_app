import 'package:financy_app/core/data/models/user_model.dart';

abstract class SessionService {
  Future<UserModel?> getLoggedUser();
  Future<bool> setLoggedUser(UserModel user);
  Future<bool> destroyLoggedUser();
}
