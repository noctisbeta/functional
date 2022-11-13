import 'package:flutter/foundation.dart';

import 'package:functional/src/either.dart';

/// Result.
@immutable
abstract class Result<F, O> implements Either<F, O> {
  /// Default constructor.
  const Result();
}

/// Instantiates a [Failure].
@immutable
class Failure<F, O> extends Result<F, O> {
  /// Default constructor.
  const Failure(F failure) : _failure = failure;

  final F _failure;

  @override
  B match<B>(B Function(F error) onFailure, B Function(O ok) onOk) => onFailure(_failure);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Failure<F, O> && other._failure == _failure;
  }

  @override
  int get hashCode => _failure.hashCode;
}

/// Instantiates an [Ok].
@immutable
class Ok<F, O> extends Result<F, O> {
  /// Default constructor.
  const Ok(O ok) : _ok = ok;

  final O _ok;

  @override
  B match<B>(B Function(F error) onFailure, B Function(O ok) onOk) => onOk(_ok);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Ok<F, O> && other._ok == _ok;
  }

  @override
  int get hashCode => _ok.hashCode;
}
