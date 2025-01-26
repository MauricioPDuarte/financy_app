import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServiceImpl implements AuthService {
  final FirebaseAuth auth;

  FirebaseAuthServiceImpl({required this.auth});

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) throw SignInFailure();

      return UserModel(
        fullName: result.user!.displayName,
        email: result.user!.email,
        avatarUrl: result.user!.photoURL,
        id: result.user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw SignInUserNotFoundFailure();
      } else if (e.code == 'wrong-password') {
        throw SignInWrongPasswordFailure();
      }
      throw SignInFailure(msg: e.message);
    } catch (e) {
      throw SignInFailure(msg: e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    String? fullName,
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) throw SignUpFailure();

      await result.user!.updateDisplayName(fullName);

      return UserModel(
        id: result.user!.uid,
        fullName: result.user!.displayName,
        email: result.user!.email,
        avatarUrl: result.user?.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists') {
        throw SignUpEmailAlreadyExistsFailure();
      } else if (e.code == 'weak-password') {
        throw SignUpWeakPasswordFailure();
      }

      throw SignUpFailure(msg: e.message);
    } catch (e) {
      throw SignUpFailure(msg: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw SignOutFailure(msg: e.message);
    } catch (e) {
      throw SignOutFailure(msg: e.toString());
    }
  }
}
