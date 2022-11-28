// ignore_for_file: public_member_api_docs

import 'package:functional/functional.dart';

typedef Result<E, O> = Either<E, O>;
typedef Err<E, O> = Left<E, O>;
typedef Ok<E, O> = Right<E, O>;

typedef AsyncResult<E, O> = Task<Either<E, O>>;

// abstract class Result<E, O> with Functor<O>, Applicative<O>, Monad<O> {
//   const Result();

//   A match<A>(A Function(E err) onError, A Function(O ok) onOk);

//   @override
//   Result<E, B> map<B>(B Function(O) f) => match(
//         Err.new,
//         (ok) => Ok(f(ok)),
//       );

//   @override
//   Result<E, A> apply<A>(covariant Result<E, A Function(O)> f) => match(
//         Err.new,
//         (ok) => f.map((g) => g(ok)),
//       );

//   @override
//   Result<E, A> bind<A>(covariant Result<E, A> Function(O) f) => match(
//         Err.new,
//         f,
//       );

//   Result<E, O> peekError(void Function(E) f) => match(
//         (err) {
//           f(err);
//           return this;
//         },
//         (ok) => this,
//       );

//   Result<E, O> peekOk(void Function(O) f) => match(
//         (err) => this,
//         (ok) {
//           f(ok);
//           return this;
//         },
//       );
// }

// class Ok<E, O> extends Result<E, O> {
//   const Ok(O value) : _value = value;

//   final O _value;

//   @override
//   A match<A>(A Function(E err) onError, A Function(O ok) onOk) => onOk(_value);
// }

// class Err<E, O> extends Result<E, O> {
//   const Err(E value) : _value = value;

//   final E _value;

//   @override
//   A match<A>(A Function(E err) onError, A Function(O ok) onOk) =>
//       onError(_value);
// }

// typedef FutureFunction<T> = Future<T> Function();

// class Attempt<E extends Object, O extends Object> {
//   Attempt.async(Future<O> Function() f) : _f = f {
//     _attempt();
//   }

//   final Future<O> Function() _f;

//   late final Task<Either<E, O>> _result;

//   void _attempt() => _result = Task<O>(_f).attempt<E>();

//   /// Evaluate.
//   Result<E, O> evaluate() => _result.then((either) => either.match(
//         Err.new,
//         Ok.new,
//       ));
// }

// class Testerino {
//   Result<String, int> test() => Attempt.async(() => Future.value(3));
// }
