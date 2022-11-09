part of functional;

/// Either [L] or [R]. Cannot be instantiated directly.
@immutable
abstract class Either<L, R> {
  /// Default constructor.
  const Either();

  /// Matches the value of the [Either] and returns the result of the coordinate functions.
  B fold<B>(B Function(L) ifLeft, B Function(R) ifRight);
}

/// Left side of [Either]. By convention this is the error side.
@immutable
class Left<L, R> extends Either<L, R> {
  /// Default constructor for [Left].
  const Left(this._l);

  final L _l;

  /// Returns the value of the left side.
  L get value => _l;

  @override
  B fold<B>(B Function(L) ifLeft, B Function(R) ifRight) => ifLeft(_l);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Left<L, R> && other._l == _l;
  }

  @override
  int get hashCode => _l.hashCode;
}

/// Right side of [Either]. By convention this is the success side.
@immutable
class Right<L, R> extends Either<L, R> {
  /// Default constructor for [Right].
  const Right(this._r);

  final R _r;

  /// Returns the value of the right side.
  R get value => _r;

  @override
  B fold<B>(B Function(L) ifLeft, B Function(R) ifRight) => ifRight(_r);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Right<L, R> && other._r == _r;
  }

  @override
  int get hashCode => _r.hashCode;
}
