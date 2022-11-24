extension ObjectExtension on Object {
  Object tap(void Function() f) {
    f();
    return this;
  }
}
