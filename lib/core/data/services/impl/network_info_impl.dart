import 'package:financy_app/core/data/services/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
