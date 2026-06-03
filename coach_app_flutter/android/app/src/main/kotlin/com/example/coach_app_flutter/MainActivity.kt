package com.example.coach_app_flutter

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "coach_app/video",
        ).setMethodCallHandler { call, result ->
            if (call.method != "openVideo") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val url = call.argument<String>("url")
            if (url.isNullOrBlank()) {
                result.error("bad_url", "Video URL is empty", null)
                return@setMethodCallHandler
            }

            val uri = Uri.parse(url)
            val browserIntent = Intent(Intent.ACTION_VIEW, uri).apply {
                addCategory(Intent.CATEGORY_BROWSABLE)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            val videoIntent = Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(uri, "video/*")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }

            try {
                startActivity(browserIntent)
                result.success(true)
            } catch (_: ActivityNotFoundException) {
                try {
                    startActivity(videoIntent)
                    result.success(true)
                } catch (error: ActivityNotFoundException) {
                    result.error("no_player", "No app can open this video", null)
                }
            }
        }
    }
}
