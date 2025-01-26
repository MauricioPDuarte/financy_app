import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/impl/firebase_auth_service_impl.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth auth;
  late MockUserCredential userCredential;
  late FirebaseAuthServiceImpl firebaseAuthService;
  late MockUser user;

  setUp(() {
    auth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    user = MockUser();
    firebaseAuthService = FirebaseAuthServiceImpl(auth: auth);
  });

  group('signIn', () {
    test('Deve retoranr um UserModel com sucesso', () async {
      // Configurando o mock para retornar um usuário
      when(() => auth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).thenAnswer((_) async => userCredential);

      when(() => userCredential.user).thenReturn(user);
      when(() => user.uid).thenReturn('user-id');
      when(() => user.email).thenReturn('test@test.com');
      when(() => user.displayName).thenReturn('Test User');
      when(() => user.photoURL).thenReturn('avatar-url');

      // Chamando o método
      final result = await firebaseAuthService.signIn(
        email: 'test@test.com',
        password: 'password123',
      );

      // Verificações
      expect(result, isA<UserModel>());
      expect(result.id, 'user-id');
      expect(result.email, 'test@test.com');
      expect(result.fullName, 'Test User');
      expect(result.avatarUrl, 'avatar-url');

      // Verifica se o método do Firebase foi chamado
      verify(() => auth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });

    test('Deve lançar SignInFailure se FirebaseAuthException ocorrer', () {
      when(() => auth.signInWithEmailAndPassword(
              email: 'test@test.com', password: 'password123'))
          .thenThrow(
              FirebaseAuthException(message: 'Erro no login', code: '200'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
        () => firebaseAuthService.signIn(
            email: 'test@test.com', password: 'password123'),
        throwsA(isA<SignInFailure>()
            .having((e) => e.msg, 'mensagem', 'Erro no login')),
      );

      // Verifica se o método foi chamado
      verify(() => auth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });

    test(
        'Deve lançar SignInUserNotFoundFailure se o usuário informado não existis',
        () {
      when(() => auth.signInWithEmailAndPassword(
              email: 'test@test.com', password: 'password123'))
          .thenThrow(FirebaseAuthException(
              message: 'Erro no login', code: 'user-not-found'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
          () => firebaseAuthService.signIn(
              email: 'test@test.com', password: 'password123'),
          throwsA(isA<SignInUserNotFoundFailure>()));

      // Verifica se o método foi chamado
      verify(() => auth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });

    test(
        'Deve lançar SignInWrongPasswordFailure se a senha do usuário estiver incorreta',
        () {
      when(() => auth.signInWithEmailAndPassword(
              email: 'test@test.com', password: 'password123'))
          .thenThrow(FirebaseAuthException(
              message: 'Erro no login', code: 'wrong-password'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
          () => firebaseAuthService.signIn(
              email: 'test@test.com', password: 'password123'),
          throwsA(isA<SignInWrongPasswordFailure>()));

      // Verifica se o método foi chamado
      verify(() => auth.signInWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });
  });

  group('signUp', () {
    test('Deve retornar um UserModel em caso de sucesso', () async {
      // Configurando o mock para retoranr um usuário
      when(() => auth.createUserWithEmailAndPassword(
          email: 'test@test.com',
          password: 'password123')).thenAnswer((_) async => userCredential);

      when(() => userCredential.user).thenReturn(user);
      when(() => user.uid).thenReturn('user-id');
      when(() => user.email).thenReturn('test@test.com');
      when(() => user.displayName).thenReturn('Test User');

      // Simula a atualização do nome
      when(() => user.updateDisplayName('Test User'))
          .thenAnswer((_) async => {});

      // Chamando o método
      final result = await firebaseAuthService.signUp(
        email: 'test@test.com',
        password: 'password123',
        fullName: 'Test User',
      );

      // Verificações
      expect(result, isA<UserModel>());
      expect(result.id, 'user-id');
      expect(result.email, 'test@test.com');
      expect(result.fullName, 'Test User');

      // Verifica se os métodos do Firebase foram chamados
      verify(() => auth.createUserWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);

      verify(() => user.updateDisplayName('Test User')).called(1);
    });

    test('Deve lançar SignUpFailure se FirebaseAuthException ocorrer',
        () async {
      // Configurando o mock para lançar uma exceção
      when(() => auth.createUserWithEmailAndPassword(
                email: 'test@test.com',
                password: 'password123',
              ))
          .thenThrow(
              FirebaseAuthException(message: 'Erro no cadastro', code: '100'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
        () => firebaseAuthService.signUp(
          email: 'test@test.com',
          password: 'password123',
        ),
        throwsA(isA<SignUpFailure>()
            .having((e) => e.msg, 'mensagem', 'Erro no cadastro')),
      );

      // Verifica se o método foi chamado
      verify(() => auth.createUserWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });

    test(
        'Deve lançar SignUpEmailAlreadyExistsFailure se o email informado já estiver em uso',
        () async {
      // Configurando o mock para lançar uma exceção
      when(() => auth.createUserWithEmailAndPassword(
                email: 'test@test.com',
                password: 'password123',
              ))
          .thenThrow(FirebaseAuthException(
              message: 'Erro no cadastro', code: 'email-already-exists'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
          () => firebaseAuthService.signUp(
                email: 'test@test.com',
                password: 'password123',
              ),
          throwsA(isA<SignUpEmailAlreadyExistsFailure>()));

      // Verifica se o método foi chamado
      verify(() => auth.createUserWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });

    test(
        'Deve lançar SignUpWeakPasswordFailure se a senha informada não atender aos critérios',
        () async {
      // Configurando o mock para lançar uma exceção
      when(() => auth.createUserWithEmailAndPassword(
                email: 'test@test.com',
                password: 'password123',
              ))
          .thenThrow(FirebaseAuthException(
              message: 'Erro no cadastro', code: 'weak-password'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
          () => firebaseAuthService.signUp(
                email: 'test@test.com',
                password: 'password123',
              ),
          throwsA(isA<SignUpWeakPasswordFailure>()));

      // Verifica se o método foi chamado
      verify(() => auth.createUserWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password123',
          )).called(1);
    });
  });

  group('signOut', () {
    test('Deve realizar o logout com sucesso', () async {
      // Configurando o mock para não lançar exceção
      when(() => auth.signOut()).thenAnswer((_) async => {});

      // Chamando o método
      await firebaseAuthService.signOut();

      // Verifica se o método foi chamado
      verify(() => auth.signOut()).called(1);
    });

    test('Deve lançar SignOutFailure se FirebaseAuthException ocorrer',
        () async {
      // Configurando o mock para lançar uma exceção
      when(() => auth.signOut()).thenThrow(
          FirebaseAuthException(message: 'Erro ao deslogar', code: '100'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
        () => firebaseAuthService.signOut(),
        throwsA(isA<SignOutFailure>()
            .having((e) => e.msg, 'mensagem', 'Erro ao deslogar')),
      );

      // Verifica se o método foi chamado
      verify(() => auth.signOut()).called(1);
    });
  });
}
