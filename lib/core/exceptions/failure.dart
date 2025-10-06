import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final response;
  const Failure([this.response]);

  @override
  List<Object?> get props => [response];
}

class ServerFailure extends Failure {
  final error;
  const ServerFailure({this.error}) : super(error);
}
