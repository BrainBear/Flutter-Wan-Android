class Result<T> {
  final T data;
  final Exception error;

  bool get isSuccessful => data != null && error == null;

  Result.success(T data)
      : data = data,
        error = null;

  Result.error(Exception exception)
      : data = null,
        error = exception;
}
