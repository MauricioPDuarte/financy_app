import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/modules/shared/data/datasouces/shared_remote_datasource.dart';

class SharedRemoteDatasourceImpl implements SharedRemoteDatasource {
  final AuthService authService;

  SharedRemoteDatasourceImpl({required this.authService});

  @override
  Future<UserModel> signInWithFacebook() async {
    return await authService.signInWithFacebook();
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return await authService.signInWithGoogle();
  }
}
