import 'dart:io';

import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/core/utils/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      if (e.code == 'email-already-in-use') {
        throw SignUpEmailAlreadyInUseFailure();
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

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (result.user == null) {
        throw SignInFailure();
      }

      return UserModel(
        id: result.user!.uid,
        fullName: result.user!.displayName,
        email: result.user!.email,
        avatarUrl: result.user?.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInFailure(msg: e.message);
    } catch (e) {
      throw SignInFailure(msg: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      var rawNonce = Crypto.generateNonce();
      final nonce = Crypto.sha256ofString(rawNonce);

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        loginTracking: LoginTracking.limited,
        nonce: nonce,
      );

      // Create a credential from the access token
      OAuthCredential facebookAuthCredential;

      if (Platform.isIOS) {
        switch (loginResult.accessToken!.type) {
          case AccessTokenType.classic:
            final token = loginResult.accessToken as ClassicToken;
            facebookAuthCredential = FacebookAuthProvider.credential(
              token.authenticationToken!,
            );
            break;
          case AccessTokenType.limited:
            final token = loginResult.accessToken as LimitedToken;
            facebookAuthCredential = OAuthCredential(
              providerId: 'facebook.com',
              signInMethod: 'oauth',
              idToken: token.tokenString,
              rawNonce: rawNonce,
            );
            break;
        }
      } else {
        facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );
      }

      // Once signed in, return the UserCredential
      var result = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (result.user == null) {
        throw SignInFailure();
      }

      return UserModel(
        id: result.user!.uid,
        fullName: result.user!.displayName,
        email: result.user!.email,
        avatarUrl: result.user?.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw SignInAccountAlreadyExistsFailure();
      }
      throw SignInFailure(msg: e.message);
    } catch (e) {
      throw SignInFailure(msg: e.toString());
    }
  }
}
