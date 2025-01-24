import 'package:financy_app/modules/sign_up/presentation/pages/sign_up_page.dart';
import 'package:financy_app/modules/sign_up/sign_up_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(SignUpRoutes.signUp, child: (context) => SignUpPage());
  }
}
