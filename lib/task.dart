part of functional;

/// A [Task].
class Task<A> {
  /// Default constructor.
  const Task(this._run);

  final Future<A> Function() _run;

  /// Runs the task.
  Future<A> run() => _run.call();

  /// Attempts to run the task.
  Task<Either<E, A>> attempt<E>() => Task(
        () => run()
            .then(
              (v) => right<E, A>(v),
            )
            .catchError(
              (err) => err is E ? left<E, A>(err) : throw err,
            ),
      );

  /// Attempts to run the task.
  Task<Option<A>> attemptOption() => Task(
        () => run()
            .then(
              (v) => some<A>(v),
            )
            .catchError(
              (err) => none<A>(),
            ),
      );
}
