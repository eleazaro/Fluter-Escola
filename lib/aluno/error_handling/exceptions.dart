import 'package:flutter_escola/core/error_handling/core_exception.dart';

class GetAlunosException extends CoreException {
  GetAlunosException(super.stackTrace, super.label, super.exception);
}

class PostAlunosException extends CoreException {
  PostAlunosException(super.stackTrace, super.label, super.exception);
}

class DeleteAlunosException extends CoreException {
  DeleteAlunosException(super.stackTrace, super.label, super.exception);
}

class PutAlunosException extends CoreException {
  PutAlunosException(super.stackTrace, super.label, super.exception);
}
