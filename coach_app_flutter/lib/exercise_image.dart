import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_config.dart';
import 'core/app_colors.dart';

class ExerciseImage extends StatelessWidget {
  final Exercise exercise;
  final double height;
  final double? width;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final Alignment alignment;

  const ExerciseImage({
    super.key,
    required this.exercise,
    required this.height,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final path = exercise.mediaUrl?.trim();

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: ColoredBox(
          color: Colors.white,
          child: _imageFor(path),
        ),
      ),
    );
  }

  Widget _imageFor(String? path) {
    if (path == null || path.isEmpty) return const _ExerciseImageFallback();

    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: fit,
        alignment: alignment,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, __, ___) => const _ExerciseImageFallback(),
      );
    }

    if (_isFullUrl(path)) return _networkImage(path);

    return FutureBuilder<String>(
      future: resolveWebServerUrl(),
      builder: (context, snapshot) {
        final baseUrl = snapshot.data;
        if (baseUrl == null) return const _ExerciseImageFallback();

        final imageUrl = Uri.parse(baseUrl).resolve(path).toString();
        return _networkImage(imageUrl);
      },
    );
  }

  Widget _networkImage(String url) {
    return Image.network(
      url,
      fit: fit,
      alignment: alignment,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, __, ___) => const _ExerciseImageFallback(),
    );
  }

  bool _isFullUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }
}

class _ExerciseImageFallback extends StatelessWidget {
  const _ExerciseImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAF5FF),
      child: const Center(
        child: Icon(
          Icons.fitness_center_rounded,
          color: AppColors.primaryBlue,
          size: 34,
        ),
      ),
    );
  }
}
