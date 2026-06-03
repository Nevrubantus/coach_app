import 'package:serverpod/serverpod.dart';

class AppConfigWidget extends JsonWidget {
  final String apiUrl;

  AppConfigWidget({
    required this.apiUrl,
  }) : super(object: {'apiUrl': apiUrl});
}

class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;
  final ServerConfig apiConfig;

  AppConfigRoute({
    required this.apiConfig,
  }) : widget = AppConfigWidget(apiUrl: apiConfig.apiUrl.toString());

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return AppConfigWidget(apiUrl: _publicApiUrl(request));
  }

  String _publicApiUrl(Request request) {
    final host = _firstHeader(request, 'x-forwarded-host') ??
        _firstHeader(request, 'host') ??
        apiConfig.publicHost;
    if (_isLocalWebServer(host)) {
      return apiConfig.apiUrl.toString();
    }

    return Uri(
      scheme: 'https',
      host: _hostWithoutPort(host),
      port: _portFromHost(host),
      path: 'serverpod/',
    ).toString();
  }
}

extension on ServerConfig {
  Uri get apiUrl => Uri(
    scheme: publicScheme,
    host: publicHost,
    port: publicPort,
  );
}

String? _firstHeader(Request request, String name) {
  final values = request.headers[name];
  if (values == null || values.isEmpty) return null;
  return values.first;
}

bool _isLocalWebServer(String host) {
  return host.startsWith('localhost:8082') ||
      host.startsWith('127.0.0.1:8082') ||
      host.startsWith('[::1]:8082');
}

String _hostWithoutPort(String host) {
  if (host.startsWith('[')) {
    final end = host.indexOf(']');
    return end == -1 ? host : host.substring(1, end);
  }

  final parts = host.split(':');
  return parts.first;
}

int? _portFromHost(String host) {
  final separator = host.lastIndexOf(':');
  if (separator == -1 || host.startsWith('[') && !host.contains(']:')) {
    return null;
  }

  return int.tryParse(host.substring(separator + 1));
}
