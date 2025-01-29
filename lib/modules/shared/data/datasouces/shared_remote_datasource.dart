import 'package:financy_app/core/data/models/user_model.dart';

abstract class SharedRemoteDatasource {
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithGoogle();
}
