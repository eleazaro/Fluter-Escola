import 'package:flutter_escola/core/error_handling/core_exception.dart';

class GetCursoByIdException extends CoreException {
  GetCursoByIdException(super.stackTrace, super.label, super.exception);
}

class GetCursosException extends CoreException {
  GetCursosException(super.stackTrace, super.label, super.exception);
}
