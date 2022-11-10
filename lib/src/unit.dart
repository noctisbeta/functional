part of functional;

/// Void.
class Unit {
  const Unit._internal();

  @override
  String toString() => '()';
}

/// Unit.
const Unit unit = Unit._internal();
