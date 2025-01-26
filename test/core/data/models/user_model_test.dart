import 'package:financy_app/core/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_values.dart';

void main() {
  group('Test UserModel', () {
    test('Deve retornar um UserModel a partir de uma UserEntity', () async {
      final model = UserModel.fromEntity(tUserEntity());

      expect(model.avatarUrl, 'url');
      expect(model.id, '123123-123123-123123');
      expect(model.password, 'Teste@123');
      expect(model.email, 'prussdev@gmail.com');
      expect(model.fullName, 'Mauricio Duarte');
    });

    test('Deve retornar um UserModel a partir de um json', () async {
      final model = UserModel.fromJson(tUserModelJSON());

      expect(model.avatarUrl, 'url');
      expect(model.id, '123123-123123-123123');
      expect(model.password, 'Teste@123');
      expect(model.email, 'prussdev@gmail.com');
      expect(model.fullName, 'Mauricio Duarte');
    });

    test('Deve retornar um UserModel a partir de um map', () async {
      final model = UserModel.fromMap({
        "avatar_url": "url",
        "email": "prussdev@gmail.com",
        "password": "Teste@123",
        "id": "123123-123123-123123",
        "full_name": "Mauricio Duarte"
      });

      expect(model.avatarUrl, 'url');
      expect(model.id, '123123-123123-123123');
      expect(model.password, 'Teste@123');
      expect(model.email, 'prussdev@gmail.com');
      expect(model.fullName, 'Mauricio Duarte');
    });

    test('Deve retornar um Map a partir de um UserModel', () async {
      expect(tUserModel().toMap(), {
        "avatar_url": "url",
        "email": "prussdev@gmail.com",
        "password": "Teste@123",
        "id": "123123-123123-123123",
        "full_name": "Mauricio Duarte"
      });
    });

    test('Deve retornar um Map a partir de um UserModel', () async {
      expect(tUserModel().toJson(), tUserModelJSON());
    });
  });
}
