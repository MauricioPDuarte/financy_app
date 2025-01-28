import 'package:financy_app/core/data/models/user_model.dart';
import 'package:financy_app/core/data/services/impl/firebase_auth_service_impl.dart';
import 'package:financy_app/core/domain/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleAuthProvider extends Mock implements AuthProvider {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockWrapperGoogleGetCredentials extends Mock
    implements WrapperGoogleGetCredentials {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUser extends Mock implements User {}

class MockOAuthCredentials extends Mock implements OAuthCredential {}

void main() {
  late MockFirebaseAuth auth;
  late MockUserCredential userCredential;
  late MockGoogleSignInAccount googleSignInAccount;
  late MockGoogleSignInAuthentication googleSignInAuthentication;
  late FirebaseAuthServiceImpl firebaseAuthService;
  late MockUser user;
  late GoogleSignIn googleSignIn;
  late MockWrapperGoogleGetCredentials googleGetCredentials;
  late MockOAuthCredentials oAuthCredentials;

  setUp(() {
    auth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    user = MockUser();
    googleSignIn = MockGoogleSignIn();
    googleGetCredentials = MockWrapperGoogleGetCredentials();
    firebaseAuthService = FirebaseAuthServiceImpl(
      firebaseAuth: auth,
      googleSignIn: googleSignIn,
      googleGetCredentials: googleGetCredentials,
    );
    googleSignInAccount = MockGoogleSignInAccount();
    googleSignInAuthentication = MockGoogleSignInAuthentication();
    oAuthCredentials = MockOAuthCredentials();
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
              message: 'Erro no cadastro', code: 'email-already-in-use'));

      // Chamando o método e verificando se lança a exceção esperada
      expect(
          () => firebaseAuthService.signUp(
                email: 'test@test.com',
                password: 'password123',
              ),
          throwsA(isA<SignUpEmailAlreadyInUseFailure>()));

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

  group('signInWithGoogle', () {
    test('Deve retornar um UserModel com sucesso', () async {
      when(() => googleSignIn.signIn())
          .thenAnswer((_) async => googleSignInAccount);

      when(() => googleSignInAccount.authentication)
          .thenAnswer((_) async => googleSignInAuthentication);

      when(() => googleSignInAuthentication.accessToken).thenReturn('123');
      when(() => googleSignInAuthentication.idToken).thenReturn('321');

      when(() => googleGetCredentials.credientials(
          accessToken: '123', idToken: '321')).thenReturn(oAuthCredentials);

      when(() => oAuthCredentials.accessToken).thenReturn('123');
      when(() => oAuthCredentials.idToken).thenReturn('321');

      when(() => auth.signInWithCredential(oAuthCredentials))
          .thenAnswer((_) async => userCredential);

      when(() => userCredential.user).thenReturn(user);
      when(() => user.uid).thenReturn('user-id');
      when(() => user.email).thenReturn('test@test.com');
      when(() => user.displayName).thenReturn('Test User');

      // ACOES
      final result = await firebaseAuthService.signInWithGoogle();

      // Verificações
      expect(result, isA<UserModel>());
      expect(result.id, 'user-id');
      expect(result.email, 'test@test.com');
      expect(result.fullName, 'Test User');
      expect(googleSignInAuthentication.accessToken, '123');
      expect(googleSignInAuthentication.idToken, '321');
      expect(oAuthCredentials.accessToken, '123');
      expect(oAuthCredentials.idToken, '321');

      verify(() => googleSignIn.signIn()).called(1);
      verify(() => googleGetCredentials.credientials(
          accessToken: '123', idToken: '321')).called(1);
      verify(() => auth.signInWithCredential(oAuthCredentials)).called(1);
    });

    test('Deve retornar um SignInFailure quando não encontrar o usuário',
        () async {
      when(() => googleSignIn.signIn())
          .thenAnswer((_) async => googleSignInAccount);

      when(() => googleSignInAccount.authentication)
          .thenAnswer((_) async => googleSignInAuthentication);

      when(() => googleSignInAuthentication.accessToken).thenReturn('123');
      when(() => googleSignInAuthentication.idToken).thenReturn('321');

      when(() => googleGetCredentials.credientials(
          accessToken: '123', idToken: '321')).thenReturn(oAuthCredentials);

      when(() => oAuthCredentials.accessToken).thenReturn('123');
      when(() => oAuthCredentials.idToken).thenReturn('321');

      when(() => auth.signInWithCredential(oAuthCredentials))
          .thenAnswer((_) async => userCredential);

      when(() => userCredential.user).thenReturn(null);

      // ACOES
      expect(() => firebaseAuthService.signInWithGoogle(),
          throwsA(isA<SignInFailure>()));

      verify(() => googleSignIn.signIn()).called(1);
    });

    test('Deve retornar um SignInFailure caso ocorra um exceção', () async {
      when(() => googleSignIn.signIn())
          .thenAnswer((_) async => googleSignInAccount);

      when(() => googleSignInAccount.authentication)
          .thenAnswer((_) async => googleSignInAuthentication);

      when(() => googleSignInAuthentication.accessToken).thenReturn('123');
      when(() => googleSignInAuthentication.idToken).thenReturn('321');

      when(() => googleGetCredentials.credientials(
          accessToken: '123', idToken: '321')).thenReturn(oAuthCredentials);

      when(() => oAuthCredentials.accessToken).thenReturn('123');
      when(() => oAuthCredentials.idToken).thenReturn('321');

      when(() => auth.signInWithCredential(oAuthCredentials))
          .thenThrow((_) async => Exception());

      // ACOES
      expect(() => firebaseAuthService.signInWithGoogle(),
          throwsA(isA<SignInFailure>()));

      verify(() => googleSignIn.signIn()).called(1);
    });
  });
}
