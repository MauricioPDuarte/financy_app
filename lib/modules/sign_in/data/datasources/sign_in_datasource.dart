import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/modules/sign_in/data/models/request_sign_in_model.dart';

abstract class SignInDatasource {
  Future<UserModel> signIn(RequestSignInModel request);
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithGoogle();
}
