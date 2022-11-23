abstract class Applicative<T> {
  const Applicative();
  Applicative<A> apply<A>(Applicative<A Function(T)> f);
}
