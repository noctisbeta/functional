import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:functional/src/abstractions/applicative.dart';
import 'package:functional/src/abstractions/functor.dart';
import 'package:functional/src/abstractions/monad.dart';
import 'package:functional/src/either.dart';

/// Sum type for representing optional values. Instances of [Option] are either
/// an instance of [Some] or the object [None].
@immutable
sealed class Option<T> implements Functor<T>, Applicative<T>, Monad<T> {
  /// Default constructor.
  const Option();

  /// Converts a [T?] to an [Option<T>].
  factory Option.of(T? value) => value == null ? None<T>() : Some<T>(value);

  /// Converts an [Option] to an [Either].
  Either<L, T> toEither<L>(L Function() onLeft) =>
      match(none: () => Left(onLeft()), some: Right.new);

  /// Pattern matching for [Option]. Provides a way to handle both [Some] and
  /// [None] cases with the provided [some] and [none] functions respectively.
  A match<A>({
    required A Function() none,
    required A Function(T value) some,
  });

  /// Unwraps the [Option] and returns the contained [T] value. Throws a state
  /// error if the [Option] is [None].
  ///
  /// Only use if you are sure that the [Option] is [Some] and being [None]
  /// is an illegal state that should terminate the program.
  T unwrap() => match(
        none: () => throw StateError('Bad state. Option is None.'),
        some: (value) => value,
      );

  /// Takes a function [f] that returns an [Option<A Function(T)>] (an option
  /// of a function that takes a [T] and returns an [A]) and applies it to this
  /// [Option]. If this [Option] is [None], the result is [None]. If this
  /// [Option] is [Some], the function [f] is applied to the value of this
  /// [Option] and the result is returned.
  @override
  Option<A> apply<A>(covariant Option<A Function(T)> f) => f.match(
        none: None<A>.new,
        some: map,
      );

  /// Takes a function [f], which takes a parameter [T] and returns a
  /// [Option<A>]. If this [Option] is [None], the result is [None]. If this
  /// [Option] is [Some], the function [f] is applied to the value of this
  /// [Option] and the result is returned.
  @override
  Option<A> bind<A>(covariant Option<A> Function(T) f) => match(
        none: None<A>.new,
        some: f,
      );

  /// Takes a function [f] and applies it to the value of this [Option]. If this
  /// [Option] is [None], the result is [None]. If this [Option] is [Some], the
  /// function [f] is applied to the value of this [Option] and the result is
  /// returned.
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
  const Some(this.value);

  /// The value of this [Some].
  final T value;

  @override
  A match<A>({
    required A Function() none,
    required A Function(T value) some,
  }) =>
      some(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Some<T> && value == other.value;

  @override
  int get hashCode => value.hashCode;
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
