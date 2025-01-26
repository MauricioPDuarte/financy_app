import 'package:financy_app/core/data/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signUp({
    String? fullName,
    required String email,
    required String password,
  });
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
