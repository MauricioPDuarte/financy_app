import 'package:financy_app/core/data/services/auth_service.dart';
import 'package:financy_app/core/data/services/impl/firebase_auth_service_impl.dart';
import 'package:financy_app/core/data/services/impl/network_info_impl.dart';
import 'package:financy_app/core/data/services/impl/session_service_impl.dart';
import 'package:financy_app/core/data/services/network_info.dart';
import 'package:financy_app/core/data/services/session_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    // Services
    i.addInstance(InternetConnectionChecker.instance);
    i.addInstance(FirebaseAuth.instance);
    i.addLazySingleton<AuthService>(FirebaseAuthServiceImpl.new);
    i.addLazySingleton<NetworkInfo>(NetworkInfoImpl.new);
    i.addLazySingleton<SessionService>(SessionServiceImpl.new);

    super.exportedBinds(i);
  }
}
