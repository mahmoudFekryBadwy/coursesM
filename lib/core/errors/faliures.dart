import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
} // for remote data

class LocationFailure extends Failure {
  const LocationFailure({required String message}) : super(message: message);
} // for location failures
