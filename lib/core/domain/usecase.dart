import 'package:either_dart/either.dart';
import 'package:financy_app/core/domain/failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P params);
}

class NoParams {}
