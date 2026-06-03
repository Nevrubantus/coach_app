import 'dart:io';

Future<bool> canReachTcp(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.host.isEmpty || uri.port == 0) return false;

  Socket? socket;
  try {
    socket = await Socket.connect(
      uri.host,
      uri.port,
      timeout: const Duration(seconds: 2),
    );
    return true;
  } catch (_) {
    return false;
  } finally {
    socket?.destroy();
  }
}
