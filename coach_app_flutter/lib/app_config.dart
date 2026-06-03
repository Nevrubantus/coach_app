import 'package:flutter/foundation.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'server_probe_stub.dart'
    if (dart.library.io) 'server_probe_io.dart'
    as server_probe;

String? _resolvedServerUrl;

Future<String> resolveServerUrl() async {
  final cachedUrl = _resolvedServerUrl;
  if (cachedUrl != null) return cachedUrl;

  final candidates = await _serverUrlCandidates();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    for (final candidate in candidates) {
      if (await _canReachServer(candidate)) {
        _resolvedServerUrl = candidate;
        return candidate;
      }
    }
  }

  _resolvedServerUrl = candidates.first;
  return candidates.first;
}

Future<List<String>> _serverUrlCandidates() async {
  const configuredServerUrl = String.fromEnvironment('SERVER_URL');
  final candidates = <String>[];

  if (configuredServerUrl.isNotEmpty) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      candidates.add(_withTrailingSlash(_androidHostUrl(configuredServerUrl)));
    }
    candidates.add(_withTrailingSlash(configuredServerUrl));
  } else if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    candidates.add('http://10.0.2.2:8080/');
    candidates.add('http://127.0.0.1:8080/');
  } else {
    candidates.add(_withTrailingSlash(await getServerUrl()));
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    candidates.add('http://10.0.2.2:8080/');
    candidates.add('http://127.0.0.1:8080/');
  }

  return _uniqueUrls(candidates);
}

Future<String> resolveWebServerUrl() async {
  if (kIsWeb) {
    return _originUrl(Uri.base);
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    return _withPort(await resolveServerUrl(), 8082);
  }

  const configuredWebServerUrl = String.fromEnvironment('WEB_SERVER_URL');
  if (configuredWebServerUrl.isNotEmpty) {
    return _withTrailingSlash(configuredWebServerUrl);
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8082/';
  }

  final serverUrl = await resolveServerUrl();
  return _withTrailingSlash(serverUrl.replaceFirst(':8080', ':8082'));
}

String _originUrl(Uri uri) {
  return _withTrailingSlash(
    Uri(
      scheme: uri.scheme,
      host: uri.host,
      port: uri.hasPort ? uri.port : null,
    ).toString(),
  );
}

String _withTrailingSlash(String url) {
  return url.endsWith('/') ? url : '$url/';
}

String _androidHostUrl(String url) {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return url;
  }

  final uri = Uri.tryParse(url);
  if (uri == null) return url;

  final host = uri.host.toLowerCase();
  if (host != 'localhost' && host != '127.0.0.1' && host != '::1') {
    return url;
  }

  return uri.replace(host: '10.0.2.2').toString();
}

String _withPort(String url, int port) {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return _withTrailingSlash(url.replaceFirst(':8080', ':$port'));
  }

  return _withTrailingSlash(uri.replace(port: port).toString());
}

List<String> _uniqueUrls(List<String> urls) {
  final seen = <String>{};
  final unique = <String>[];

  for (final url in urls) {
    final normalized = _withTrailingSlash(url);
    if (seen.add(normalized)) unique.add(normalized);
  }

  return unique;
}

Future<bool> _canReachServer(String url) async {
  return server_probe.canReachTcp(url);
}
