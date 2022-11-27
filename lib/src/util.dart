import 'package:functional/src/unit.dart';

/// Calls [f] before returning [toReturn].
A withEffect<A, B>(A toReturn, B Function() f) {
  f();
  return toReturn;
}

/// Calls [f] before returning [tapped].
A tap<A, B>(A tapped, B Function() f) {
  f();
  return tapped;
}

/// Calls [f] before returning [unit].
Unit effect(void Function() f) {
  f();
  return unit;
}
