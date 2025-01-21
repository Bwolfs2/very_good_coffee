abstract class Result<TError, TSuccess> {
  /// Constructs a new [Result] instance.
  const Result();

  /// Executes the provided functions based on the result's state.
  ///
  /// If the result is an error, [onError] is called with the error value.
  /// If the result is a success, [onSuccess] is called with the success value.
  T fold<T>(T Function(TError l) onError, T Function(TSuccess r) onSuccess);

  /// Returns the success value if the result is a success,
  /// otherwise calls [orElse] with the error value and returns its result.
  TSuccess getOrElse(TSuccess Function(TError error) orElse);

  /// Maps the result to a new type using the provided function.
  Result<TError, T> map<T>(T Function(TSuccess r) fn) {
    return fold((e) => Error(e), (r) => Success(fn(r)));
  }

  /// Factory constructor to create a success result.
  factory Result.success(TSuccess value) => Success(value);

  /// Factory constructor to create an error result.
  factory Result.error(TError value) => Error(value);
}

/// Represents an error result.
class Error<TError, TSuccess> extends Result<TError, TSuccess> {
  /// Constructs a new [Error] instance.
  const Error(this._value);

  /// The error value.
  final TError _value;

  @override
  T fold<T>(T Function(TError l) onError, T Function(TSuccess r) onSuccess) {
    return onError(_value);
  }

  @override
  TSuccess getOrElse(TSuccess Function(TError error) orElse) {
    return orElse(_value);
  }
}

class Success<TError, TSuccess> extends Result<TError, TSuccess> {
  /// Constructs a new [Success] instance.
  const Success(this._value);

  /// The success value.
  final TSuccess _value;

  @override
  T fold<T>(
      T Function(TError error) onError, T Function(TSuccess r) onSuccess) {
    return onSuccess(_value);
  }

  @override
  TSuccess getOrElse(TSuccess Function(TError error) orElse) {
    return _value;
  }
}

/// Represents a unit value.
class Unit {
  /// Constructs a new [Unit] instance.
  const Unit();
}

/// The singleton instance of [Unit].
const unit = Unit();
