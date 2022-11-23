import 'package:flutter/foundation.dart';
import 'package:functional/src/abstractions/applicative.dart';
import 'package:functional/src/abstractions/functor.dart';
import 'package:functional/src/abstractions/monad.dart';

/// Option.
@immutable
abstract class Option<T> implements Functor<T>, Applicative<T>, Monad<T> {
  /// Default constructor.
  const Option();

  /// Option of constructor.
  factory Option.of(T? value) => value == null ? None<T>() : Some<T>(value);

  /// Match.
  A match<A>(A Function() ifNone, A Function(T some) ifSome);
}

/// Instantiates a [None].
None<T> none<T>() => const None();

/// Instantiates a [Some].
Some<T> some<T>(T a) => Some(a);

/// Creates an [Option] from a nullable value.
Option<T> optionOf<T>(T? value) => value == null ? None<T>() : Some<T>(value);

/// Instantiates a [Some].
@immutable
class Some<T> extends Option<T> {
  /// Default constructor.
  const Some(T value) : _value = value;

  final T _value;

  @override
  A match<A>(A Function() ifNone, A Function(T some) ifSome) => ifSome(_value);

  @override
  Some<A> map<A>(A Function(T) f) => Some(f(_value));

  @override
  Option<A> apply<A>(covariant Option<A Function(T)> f) =>
      f.match(none, (func) => Some(func(_value)));

  @override
  Option<A> bind<A>(covariant Option<A> Function(T) f) => f(_value);

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
  A match<A>(A Function() ifNone, A Function(T some) ifSome) => ifNone();

  @override
  None<A> map<A>(A Function(T) f) => None<A>();

  @override
  None<A> apply<A>(covariant None<A Function(T p1)> f) => None<A>();

  @override
  None<A> bind<A>(covariant Option<A> Function(T) f) => None<A>();

  @override
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => 0;
}
