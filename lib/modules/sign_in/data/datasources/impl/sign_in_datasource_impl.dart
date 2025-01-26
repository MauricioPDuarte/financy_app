import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/modules/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:financy_app/modules/sign_in/data/models/request_sign_in_model.dart';

class SignInDatasourceImpl implements SignInDatasource {
  final AuthService authService;

  SignInDatasourceImpl({required this.authService});

  @override
  Future<UserModel> signIn(RequestSignInModel request) async {
    return await authService.signIn(
      email: request.email,
      password: request.password,
    );
  }
}
