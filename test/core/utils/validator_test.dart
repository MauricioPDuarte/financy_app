import 'package:financy_app/core/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test validateEmail()', () {
    test('Deve retornar null indicando que o valor informado está correto', () {
      var email1 = 'prussdev@gmail.com';
      var email2 = 'pruss.dev@gmail.com';
      var email3 = 'prussdev@gmail.com.br';
      var email4 = 'pruss.dev.teste@gmail.com';
      var email5 = 't@gmail.com';

      expect(Validator.validateEmail(email1), isNull);
      expect(Validator.validateEmail(email2), isNull);
      expect(Validator.validateEmail(email3), isNull);
      expect(Validator.validateEmail(email4), isNull);
      expect(Validator.validateEmail(email5), isNull);
    });

    test(
        'Deve retornar uma mensagem de erro indicando que o valor informado está incorreto',
        () {
      var email1 = 'prussdevgmail.com';
      var email2 = 'prussdev@gmail';
      var email3 = '@gmail.com';
      var email4 = '.com';

      expect(Validator.validateEmail(email1), 'Email inválido.');
      expect(Validator.validateEmail(email2), 'Email inválido.');
      expect(Validator.validateEmail(email3), 'Email inválido.');
      expect(Validator.validateEmail(email4), 'Email inválido.');
    });

    test('Deve retornar uma mensagem de erro quando não for informado nada',
        () {
      var email = '';

      final result = Validator.validateEmail(email);

      expect(result, 'Esse campo não pode ser vazio.');
    });
  });

  group('Test validateFullName', () {
    test('Deve retornar null indicando que o valor informado está correto', () {
      var name1 = 'Mauricio Pruss';
      var name2 = 'Mauricio Pruss Duarte';
      var name3 = 'Ageu da Costa Duarte';
      var name4 = 'Ageu Da Costa Duarte';

      expect(Validator.validateFullName(name1), isNull);
      expect(Validator.validateFullName(name2), isNull);
      expect(Validator.validateFullName(name3), isNull);
      expect(Validator.validateFullName(name4), isNull);
    });

    test(
        'Deve retornar uma mensagem de erro indicando que o valor informado está incorreto',
        () {
      var name1 = 'Mauricio';
      var name2 = 'Mau';
      var name3 = 'M';
      var name4 = 'Mauricio Duarte e Silva';
      var name5 = 'Mauricio.Duarte e Silva';
      var name6 = 'Mauricio@Duarte e Silva';

      expect(Validator.validateFullName(name1), 'Nome inválido.');
      expect(Validator.validateFullName(name2), 'Nome inválido.');
      expect(Validator.validateFullName(name3), 'Nome inválido.');
      expect(Validator.validateFullName(name4), 'Nome inválido.');
      expect(Validator.validateFullName(name5), 'Nome inválido.');
      expect(Validator.validateFullName(name6), 'Nome inválido.');
    });

    test('Deve retornar uma mensagem de erro quando não for informado nada',
        () {
      var name = '';

      final result = Validator.validateFullName(name);

      expect(result, 'Esse campo não pode ser vazio.');
    });
  });

  group('Test validatePassword()', () {
    test('Deve retornar null indicando que o valor informado está correto', () {
      var password1 = 'Password1';
      var password2 = 'HelloWorld2';
      var password3 = 'Secure@123';
      var password4 = 'A1b2C3d4';
      var password5 = 'Valid!123';

      expect(Validator.validatePassword(password1), isNull);
      expect(Validator.validatePassword(password2), isNull);
      expect(Validator.validatePassword(password3), isNull);
      expect(Validator.validatePassword(password4), isNull);
      expect(Validator.validatePassword(password5), isNull);
    });

    test(
        'Deve retornar uma mensagem de erro indicando que o valor informado está incorreto',
        () {
      var password1 = 'password123';
      var password2 = 'Password!';
      var password3 = 'Pass1!';
      var password4 = 'Password123*';

      expect(Validator.validatePassword(password1),
          'A senha não atende aos critérios obrigatórios.');
      expect(Validator.validatePassword(password2),
          'A senha não atende aos critérios obrigatórios.');
      expect(Validator.validatePassword(password3),
          'A senha não atende aos critérios obrigatórios.');
      expect(Validator.validatePassword(password4),
          'A senha não atende aos critérios obrigatórios.');
    });

    test('Deve retornar uma mensagem de erro quando não for informado nada',
        () {
      var password = '';

      final result = Validator.validatePassword(password);

      expect(result, 'Esse campo não pode ser vazio.');
    });
  });

  group('Test validateConfirmPassword', () {
    test('Deve retornar null indicando que o valor informado está correto', () {
      var senha = 'Teste@123';
      var confirm = 'Teste@123';

      final result = Validator.validateConfirmPassword(senha, confirm);

      expect(result, isNull);
    });

    test(
        'Deve retornar uma mensagem de erro indicando que o valor informado está incorreto',
        () {
      var senha = 'Teste@123';
      var confirm = 'Teste@12423';

      final result = Validator.validateConfirmPassword(senha, confirm);

      expect(result, 'As senhas informadas são diferentes.');
    });
  });
}
