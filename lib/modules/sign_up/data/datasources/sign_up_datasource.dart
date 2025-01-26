import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/modules/sign_up/data/models/request_sign_up_model.dart';

abstract class SignUpDatasource {
  Future<UserModel> signUp(RequestSignUpModel request);
}
