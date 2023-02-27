import 'package:flutter_escola/core/error_handling/core_exception.dart';

class GetCursoByIdException extends CoreException {
  GetCursoByIdException(super.stackTrace, super.label, super.exception);
}

class GetCursosException extends CoreException {
  GetCursosException(super.stackTrace, super.label, super.exception);
}

class PostCursosException extends CoreException {
  PostCursosException(super.stackTrace, super.label, super.exception);
}

class DeleteCursosException extends CoreException {
  DeleteCursosException(super.stackTrace, super.label, super.exception);
}

class PutCursosException extends CoreException {
  PutCursosException(super.stackTrace, super.label, super.exception);
}

class GetMatriculaCursoException extends CoreException {
  GetMatriculaCursoException(super.stackTrace, super.label, super.exception);
}

class GetMatriculaAlunoException extends CoreException {
  GetMatriculaAlunoException(super.stackTrace, super.label, super.exception);
}

class PostMatriculaException extends CoreException {
  PostMatriculaException(super.stackTrace, super.label, super.exception);
}

class DeleteMatriculaException extends CoreException {
  DeleteMatriculaException(super.stackTrace, super.label, super.exception);
}
