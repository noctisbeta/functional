import 'package:flutter/foundation.dart';

/// Option.
@immutable
abstract class Option<A> {
  /// Default constructor.
  const Option();

  /// Match.
  B fold<B>(B Function() ifNone, B Function(A some) ifSome);
}

/// Instantiates a [None].
Option<A> none<A>() => const None();

/// Instantiates a [Some].
Option<A> some<A>(A a) => Some(a);

/// Creates an [Option] from a nullable value.
Option<A> optionOf<A>(A? value) => value != null ? some(value) : none();

/// Instantiates a [Some].
@immutable
class Some<A> extends Option<A> {
  /// Default constructor.
  const Some(this._a);

  final A _a;

  /// Returns the value of the [Some].
  A get value => _a;

  @override
  B fold<B>(B Function() ifNone, B Function(A some) ifSome) => ifSome(_a);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Some<A> && other._a == _a;
  }

  @override
  int get hashCode => _a.hashCode;
}

/// Instantiates a [None].
@immutable
class None<A> extends Option<A> {
  /// Default constructor.
  const None();

  @override
  B fold<B>(B Function() ifNone, B Function(A some) ifSome) => ifNone();
}
