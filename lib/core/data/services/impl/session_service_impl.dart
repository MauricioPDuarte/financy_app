import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/session_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionServiceImpl implements SessionService {
  final FlutterSecureStorage flutterSecureStorage;

  SessionServiceImpl({FlutterSecureStorage? flutterSecureStorage})
      : flutterSecureStorage =
            flutterSecureStorage ?? const FlutterSecureStorage();

  final userKey = 'user-session';

  @override
  Future<bool> destroyLoggedUser() async {
    try {
      final exists = await flutterSecureStorage.containsKey(key: userKey);

      if (exists) {
        await flutterSecureStorage.delete(key: userKey);
      }

      return true;
    } on Exception {
      return false;
    }
  }

  @override
  Future<UserModel?> getLoggedUser() async {
    try {
      final result = await flutterSecureStorage.read(key: userKey);
      if (result == null) {
        return null;
      }

      return UserModel.fromJson(result);
    } on Exception {
      return null;
    }
  }

  @override
  Future<bool> setLoggedUser(UserModel user) async {
    try {
      await flutterSecureStorage.write(key: userKey, value: user.toJson());
      return true;
    } on Exception {
      return false;
    }
  }
}
