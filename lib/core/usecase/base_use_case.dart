import 'package:dartz/dartz.dart';
import 'package:task2/core/exceptions/failure.dart';

abstract class BaseUseCase<Type, Map> {
  //handling error using dartz package
  Future<Either<Failure, Type>> call(Map params);
}
