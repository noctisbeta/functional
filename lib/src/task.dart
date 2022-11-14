import 'package:flutter/cupertino.dart';
import 'package:functional/src/either.dart';

@immutable

/// A [Task].
class Task<A> {
  /// Default constructor.
  const Task(Future<A> Function() task) : _run = task;

  final Future<A> Function() _run;

  /// Runs the task.
  Future<A> run() => _run.call();

  /// Use for async apis that return [A] and can throw [E].
  Task<Either<E, A>> attempt<E>() => Task(
        () => run()
            .then(
              (v) => right<E, A>(v),
            )
            .catchError(
              (err) => err is E ? left<E, A>(err) : throw err,
            ),
      );

  /// Use for async apis that return null instead of throwing an exception.
  Task<Either<Exception, A>> attemptNullToException(Exception e) => Task<Either<Exception, A>>(
        () => run().then(
          (v) => v == null ? left<Exception, A>(e) : right<Exception, A>(v),
        ),
      );
}
