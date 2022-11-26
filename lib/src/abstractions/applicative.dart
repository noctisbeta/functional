mixin Applicative<T> {
  Applicative<A> apply<A>(Applicative<A Function(T)> f);
}
