import 'package:flutter/foundation.dart';

/// Either [L] or [R]. Cannot be instantiated directly.
@immutable
abstract class Either<L, R> {
  /// Default constructor.
  const Either();

  /// Matches the value of the [Either] and returns the result of the coordinate functions.
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight);
}

/// Instantiates a [Left].
Either<L, R> left<L, R>(L left) => Left(left);

/// Instantiates a [Right] value.
Either<L, R> right<L, R>(R right) => Right(right);

/// Left side of [Either]. By convention this is the error side.
@immutable
class Left<L, R> extends Either<L, R> {
  /// Default constructor for [Left].
  const Left(L left) : _left = left;

  final L _left;

  @override
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight) => onLeft(_left);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Left<L, R> && other._left == _left;
  }

  @override
  int get hashCode => _left.hashCode;
}

/// Right side of [Either]. By convention this is the success side.
@immutable
class Right<L, R> extends Either<L, R> {
  /// Default constructor for [Right].
  const Right(R right) : _right = right;

  final R _right;

  @override
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight) => onRight(_right);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Right<L, R> && other._right == _right;
  }

  @override
  int get hashCode => _right.hashCode;
}
