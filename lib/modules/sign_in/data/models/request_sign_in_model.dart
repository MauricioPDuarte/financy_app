import 'package:financy_app/modules/sign_in/domain/entities/request_sign_in_entity.dart';

class RequestSignInModel extends RequestSignInEntity {
  const RequestSignInModel({required super.email, required super.password});

  static RequestSignInModel fromEntity(RequestSignInEntity entity) {
    return RequestSignInModel(email: entity.email, password: entity.password);
  }
}
