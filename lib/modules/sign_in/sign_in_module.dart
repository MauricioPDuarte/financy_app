import 'package:financy_app/modules/sign_in/presentation/pages/sign_in_page.dart';
import 'package:financy_app/modules/sign_in/sign_in_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(SignInRoutes.signIn, child: (context) => SignInPage());
  }
}
