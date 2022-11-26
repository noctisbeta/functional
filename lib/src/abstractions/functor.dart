// ignore_for_file: one_member_abstracts

/// Wraps [T] and provides a way to map it.
mixin Functor<T> {
  /// Default constructor.
  // const Functor();

  /// Given [f], maps the wrapped [T] to a wrapped [A] := f(T).
  Functor<A> map<A>(A Function(T) f);
}
