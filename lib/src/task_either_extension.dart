import 'package:functional/src/either.dart';
import 'package:functional/src/task.dart';

/// Extension for [Task<Either<L, R>].
extension TaskEitherExtension<L, R> on Task<Either<L, R>> {
  /// Peek either.
  Task<Either<L, R>> peekEither(
    void Function(L left) onLeft,
    void Function(R right) onRight,
  ) =>
      Task(
        () => run().then(
          (either) => either.match(
            (left) {
              onLeft(left);
              return either;
            },
            (right) {
              onRight(right);
              return either;
            },
          ),
        ),
      );

  /// Peek either left.
  Task<Either<L, R>> peekEitherLeft(void Function(L left) onLeft) => Task(
        () => run().then(
          (either) => either.match(
            (left) {
              onLeft(left);
              return either;
            },
            (right) => either,
          ),
        ),
      );

  /// Peek either right.
  Task<Either<L, R>> peekEitherRight(void Function(R right) onRight) => Task(
        () => run().then(
          (either) => either.match(
            (left) => either,
            (right) {
              onRight(right);
              return either;
            },
          ),
        ),
      );

  /// Map either right.
  Task<Either<L, S>> mapEitherRight<S>(S Function(R right) f) => Task(
        () => run().then(
          (either) => either.match(
            Left.new,
            (right) => Right(f(right)),
          ),
        ),
      );

  /// Bind either.
  Task<Either<L, S>> bindEither<S>(Task<Either<L, S>> Function(R right) f) =>
      Task(
        () => run().then(
          (either) async => either.match(
            left,
            (r) => f(r).run(),
          ),
        ),
      );
}
