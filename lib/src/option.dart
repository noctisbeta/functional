import 'package:flutter/foundation.dart';
import 'package:functional/src/abstractions/applicative.dart';
import 'package:functional/src/abstractions/functor.dart';
import 'package:functional/src/abstractions/monad.dart';
import 'package:functional/src/either.dart';

/// Sum type for representing optional values. Instances of [Option] are either
/// an instance of [Some] or the object [None].
@immutable
abstract class Option<T> implements Functor<T>, Applicative<T>, Monad<T> {
  /// Default constructor.
  const Option();

  /// Converts a [T?] to an [Option<T>].
  factory Option.of(T? value) => value == null ? None<T>() : Some<T>(value);

  /// Converts an [Option] to an [Either].
  Either<L, T> toEither<L>(L left) =>
      match(none: () => Left(left), some: Right.new);

  /// Pattern matching for [Option]. Provides a way to handle both [Some] and
  /// [None] cases with the provided [some] and [none] functions respectively.
  A match<A>({
    required A Function() none,
    required A Function(T value) some,
  });

  @override
  Option<A> apply<A>(covariant Option<A Function(T)> f) => f.match(
        none: None<A>.new,
        some: map,
      );

  @override
  Option<A> bind<A>(covariant Option<A> Function(T) f) => match(
        none: None<A>.new,
        some: f,
      );

  @override
  Option<A> map<A>(A Function(T) f) => match(
        none: None<A>.new,
        some: (value) => Some<A>(f(value)),
      );
}

/// Instantiates a [Some].
@immutable
class Some<T> extends Option<T> {
  /// Default constructor.
  const Some(T value) : _value = value;

  final T _value;

  @override
  A match<A>({
    required A Function() none,
    required A Function(T value) some,
  }) =>
      some(_value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Some<T> && _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}

/// Instantiates a [None].
@immutable
class None<T> extends Option<T> {
  /// Default constructor.
  const None();

  @override
  A match<A>({
    required A Function() none,
    required A Function(T value) some,
  }) =>
      none();

  @override
  bool operator ==(Object other) => identical(this, other) || other is None;

  @override
  int get hashCode => 0;
}
