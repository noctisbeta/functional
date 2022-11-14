/// Calls [f] before returning [toReturn].
A withEffect<A, B>(A toReturn, B Function() f) {
  f();
  return toReturn;
}
