/// Bool extension.
extension BoolExtension on bool {
  /// Matches the value of the [bool] and returns the result of the coordinate functions.
  B match<B>({
    required B Function() ifFalse,
    required B Function() ifTrue,
  }) =>
      this ? ifTrue.call() : ifFalse.call();
}
