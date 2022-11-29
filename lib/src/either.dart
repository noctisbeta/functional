import 'package:flutter/foundation.dart';
import 'package:functional/src/abstractions/applicative.dart';
import 'package:functional/src/abstractions/functor.dart';
import 'package:functional/src/abstractions/monad.dart';

/// Either [L] or [R]. Cannot be instantiated directly.
@immutable
abstract class Either<L, R> with Functor<R>, Applicative<R>, Monad<R> {
  /// Default constructor.
  const Either();

  /// Converts a nullable to [Either].
  factory Either.fromNullable(R? r, L Function() onNull) =>
      r != null ? Right(r) : Left(onNull());

  /// Matches the value of the [Either] and returns the result of the coordinate
  /// functions.
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight);

  @override
  Either<L, B> map<B>(B Function(R) f);

  @override
  Either<L, A> apply<A>(covariant Either<L, A Function(R)> f);

  @override
  Either<L, A> bind<A>(covariant Either<L, A> Function(R) f);

  /// Peek at the value of the [Either] without changing it.
  Either<L, R> peekLeft(void Function(L) f) => match(
        (left) {
          f(left);
          return this;
        },
        (right) => this,
      );
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
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight) =>
      onLeft(_left);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Left<L, R> && other._left == _left;

  @override
  int get hashCode => _left.hashCode;

  @override
  Either<L, A> apply<A>(covariant Either<L, A Function(R p1)> f) => Left(_left);

  @override
  Either<L, A> bind<A>(covariant Either<L, A> Function(R p1) f) => Left(_left);

  @override
  Either<L, A> map<A>(A Function(R) f) => Left(_left);
}

/// Right side of [Either]. By convention this is the success side.
@immutable
class Right<L, R> extends Either<L, R> {
  /// Default constructor for [Right].
  const Right(R right) : _right = right;

  final R _right;

  @override
  B match<B>(B Function(L left) onLeft, B Function(R right) onRight) =>
      onRight(_right);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Right<L, R> && other._right == _right;

  @override
  int get hashCode => _right.hashCode;

  @override
  Either<L, A> apply<A>(covariant Either<L, A Function(R)> f) =>
      f.match(left, (func) => Right(func(_right)));

  @override
  Either<L, A> bind<A>(covariant Either<L, A> Function(R) f) => f(_right);

  @override
  Either<L, A> map<A>(A Function(R) f) => Right(f(_right));
}
