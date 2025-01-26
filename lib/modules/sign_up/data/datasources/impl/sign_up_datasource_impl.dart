import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/auth_service.dart';

import 'package:financy_app/modules/sign_up/data/datasources/sign_up_datasource.dart';
import 'package:financy_app/modules/sign_up/data/models/request_sign_up_model.dart';

class SignUpDatasourceImpl implements SignUpDatasource {
  final AuthService authService;

  SignUpDatasourceImpl({
    required this.authService,
  });

  @override
  Future<UserModel> signUp(RequestSignUpModel request) async {
    return await authService.signUp(
        email: request.email,
        fullName: request.fullName,
        password: request.password);
  }
}
