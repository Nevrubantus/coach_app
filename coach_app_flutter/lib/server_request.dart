import 'dart:async';

const serverRequestTimeout = Duration(seconds: 10);
const serverUploadTimeout = Duration(minutes: 5);

Future<T> waitForServer<T>(
  Future<T> request, {
  Duration timeout = serverRequestTimeout,
}) {
  return Future.any([
    request,
    Future<T>.delayed(
      timeout,
      () => throw TimeoutException('Server request timeout'),
    ),
  ]);
}
