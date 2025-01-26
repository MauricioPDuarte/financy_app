import 'package:financy_app/modules/sign_up/domain/entities/request_sign_up_entity.dart';

class RequestSignUpModel extends RequestSignUpEntity {
  const RequestSignUpModel({
    super.fullName,
    required super.email,
    required super.password,
  });

  static RequestSignUpModel fromEntity(RequestSignUpEntity entity) {
    return RequestSignUpModel(
      email: entity.email,
      fullName: entity.fullName,
      password: entity.password,
    );
  }
}
