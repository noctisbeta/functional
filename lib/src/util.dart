import 'package:functional/src/unit.dart';

/// Calls [effect] before returning [tapped].
A tap<A>({required A tapped, required Function() effect}) {
  effect();
  return tapped;
}

/// Calls [f] before returning [unit].
Unit effect(void Function() f) {
  f();
  return unit;
}
