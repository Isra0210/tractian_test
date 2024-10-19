import 'package:flutter/cupertino.dart';

abstract class Failure implements Exception {
  final String errorMessage;

  Failure({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
  }
}

class GetCompaniesFailure extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetCompaniesFailure({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureCompanies',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}

class GetLocationsFailure extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetLocationsFailure({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureLocations',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}

class GetAssetsFailure extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  GetAssetsFailure({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'GetFailureAssets',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}

class UnknownError extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  UnknownError({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'Unknown Error',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
