import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_launcher_web_stub.dart'
    if (dart.library.html) 'video_launcher_web.dart'
    as web_video;

class VideoLauncher {
  static const _channel = MethodChannel('coach_app/video');

  static Future<bool> open(String url) async {
    if (kIsWeb) {
      return web_video.openVideoUrl(url);
    }

    if (defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    return await _channel.invokeMethod<bool>('openVideo', {'url': url}) ??
        false;
  }
}
