import 'package:flutter/material.dart';

class CoreException implements Exception {
  CoreException(StackTrace? stackTrace, String? label, dynamic exception) {
    debugPrintStack(label: 'Exception :: $label', stackTrace: stackTrace);
  }
}

class GetException extends CoreException {
  GetException(StackTrace stackTrace, String label, exception)
      : super(stackTrace, label, exception);
}

class PostException extends CoreException {
  PostException(StackTrace stackTrace, String label, exception)
      : super(stackTrace, label, exception);
}
