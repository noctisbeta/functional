mixin Monad<T> {
  /// Given [f], maps the wrapped [T] to a wrapped [A] := f(T).
  Monad<A> bind<A>(Monad<A> Function(T) f);
}
