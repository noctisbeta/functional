import 'package:functional/src/unit.dart';

/// Calls [effect] before returning [tapped].
A tap<A, B>({required A tapped, required B Function() effect}) {
  effect();
  return tapped;
}

/// Calls [f] before returning [unit].
Unit effect(void Function() f) {
  f();
  return unit;
}
