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
}
