import 'dart:async';

const serverRequestTimeout = Duration(seconds: 10);

Future<T> waitForServer<T>(Future<T> request) {
  return Future.any([
    request,
    Future<T>.delayed(
      serverRequestTimeout,
      () => throw TimeoutException('Server request timeout'),
    ),
  ]);
}
