import 'package:flutter/cupertino.dart';
import 'package:functional/src/abstractions/applicative.dart';
import 'package:functional/src/abstractions/functor.dart';
import 'package:functional/src/abstractions/monad.dart';
import 'package:functional/src/either.dart';
import 'package:functional/src/option.dart';
import 'package:functional/src/unit.dart';

@immutable

/// T [Task].
class Task<T> implements Functor<T>, Applicative<T>, Monad<T> {
  /// Default constructor.
  const Task(Future<T> Function() task) : _run = task;

  /// Converts void to unit.
  static Task<Unit> fromVoid(Future<void> Function() task) => Task(
        () async {
          await task();
          return Future.value(unit);
        },
      );

  /// Converts nullable to option.
  static Task<Option<B>> fromNullable<B>(Future<B?> Function() task) => Task(
        () =>
            task().then((value) => value == null ? None<B>() : Some<B>(value)),
      );

  final Future<T> Function() _run;

  /// Runs the task.
  Future<T> run() => _run.call();

  /// Use for async apis that return [T] and can throw [E].
  Task<Either<E, T>> attempt<E extends Object>() => Task(
        () => run()
            .then(
              (v) => right<E, T>(v),
            )
            .onError<E>(
              (error, stackTrace) => left<E, T>(error),
            ),
      );

  /// Use for async apis that return [T] and can throw exceptions.
  Task<Either<Exception, T>> attemptException() => Task(
        () => run()
            .then(
              (v) => right<Exception, T>(v),
            )
            .onError<Exception>(
              (error, stackTrace) => left<Exception, T>(error),
            ),
      );

  /// Use for async apis that return [T] and can throw objects.
  Task<Either<Object, T>> attemptObject() => Task(
        () => run()
            .then(
              (v) => right<Object, T>(v),
            )
            .onError<Object>(
              (error, stackTrace) => left<Object, T>(error),
            ),
      );

  /// Use for async apis that return [T] and you want to catch everything.
  Task<Either<dynamic, T>> attemptAll() => Task(
        () => run()
            .then(
              (v) => right<dynamic, T>(v),
            )
            .onError(
              (error, stackTrace) => left<dynamic, T>(error),
            ),
      );

  /// Use for async apis that return null instead of throwing an exception.
  Task<Either<Exception, T>> attemptNullToException(Exception e) => Task(
        () => run().then(
          (v) => v == null ? Left<Exception, T>(e) : Right<Exception, T>(v),
        ),
      );

  @override
  Task<A> map<A>(A Function(T) f) => Task(() => run().then(f));

  @override
  Task<A> apply<A>(covariant Task<A Function(T)> f) => f.bind(map);

  @override
  Task<A> bind<A>(covariant Task<A> Function(T) f) =>
      Task(() => run().then((val) => f(val).run()));

  /// Peek at the value of the task and run a side effect, then return the same
  /// value that was peeked.
  Task<T> peek(void Function(T) f) => Task(
        () => run().then((val) {
          f(val);
          return val;
        }),
      );
}
