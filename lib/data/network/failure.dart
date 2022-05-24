import 'error_handler.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  int code;
  String message;

  Failure(this.code, this.message);

  @override
  List<Object> get props => [code];
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
