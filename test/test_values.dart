import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/domain/entities/user_entity.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:financy_app/modules/sign_in/data/models/request_sign_in_model.dart';
import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';
import 'package:financy_app/modules/sign_up/data/models/request_sign_up_model.dart';
import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';

UserEntity Function() tUserEntity = () => UserEntity(
    fullName: 'Mauricio Duarte',
    email: 'prussdev@gmail.com',
    password: 'Teste@123',
    id: '123123-123123-123123',
    avatarUrl: 'url');

UserModel Function() tUserModelWithId = () => UserModel(
    fullName: 'Mauricio Duarte',
    email: 'prussdev@gmail.com',
    password: 'Teste@123',
    id: '123123');

UserModel Function() tUserModel = () => UserModel(
      fullName: 'Mauricio Duarte',
      email: 'prussdev@gmail.com',
      password: 'Teste@123',
      id: '123123-123123-123123',
      avatarUrl: 'url',
    );

RequestSignUpEntity Function() tRequestSignUpEntity = () => RequestSignUpEntity(
      fullName: 'Mauricio Duarte',
      email: 'prussdev@gmail.com',
      password: 'Teste@123',
    );

RequestSignInEntity Function() tRequestSignInEntity = () => RequestSignInEntity(
      email: 'prussdev@gmail.com',
      password: 'Teste@123',
    );

RequestSignUpModel Function() tRequestSignUpModel = () => RequestSignUpModel(
      fullName: 'Mauricio Duarte',
      email: 'prussdev@gmail.com',
      password: 'Teste@123',
    );

RequestSignInModel Function() tRequestSignInModel = () => RequestSignInModel(
      email: 'prussdev@gmail.com',
      password: 'Teste@123',
    );

String Function() tUserModelJSON = () =>
    '{"avatar_url":"url","email":"prussdev@gmail.com","password":"Teste@123","id":"123123-123123-123123","full_name":"Mauricio Duarte"}';

Failure Function() tNoConnection = () => NoConnection();
Failure Function() tApiFailure = () => ApiFailure();
Failure Function() tUnexpectedFailure = () => UnexpectedFailure();
