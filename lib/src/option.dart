import 'package:flutter/foundation.dart';

/// Option.
@immutable
abstract class Option<A> {
  /// Default constructor.
  const Option();

  /// Option of constructor.
  factory Option.of(A? value) => value == null ? None<A>() : Some<A>(value);

  /// Match.
  B match<B>(B Function() ifNone, B Function(A some) ifSome);
}

/// Instantiates a [None].
Option<A> none<A>() => const None();

/// Instantiates a [Some].
Option<A> some<A>(A a) => Some(a);

/// Creates an [Option] from a nullable value.
Option<A> optionOf<A>(A? value) => value == null ? None<A>() : Some<A>(value);

/// Instantiates a [Some].
@immutable
class Some<A> extends Option<A> {
  /// Default constructor.
  const Some(A some) : _some = some;

  final A _some;

  @override
  B match<B>(B Function() ifNone, B Function(A some) ifSome) => ifSome(_some);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Some<A> && other._some == _some;
  }

  @override
  int get hashCode => _some.hashCode;
}

/// Instantiates a [None].
@immutable
class None<A> extends Option<A> {
  /// Default constructor.
  const None();

  @override
  B match<B>(B Function() ifNone, B Function(A some) ifSome) => ifNone();
}
