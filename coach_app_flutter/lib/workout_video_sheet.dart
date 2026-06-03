import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'app_ui.dart';
import 'core/app_colors.dart';
import 'profile_avatar_editor.dart';
import 'training_formatters.dart';

class WorkoutVideoSheet extends StatefulWidget {
  final List<WorkoutVideo> videos;
  final Map<int, List<VideoComment>> commentsByVideoId;
  final Map<int, User> commentAuthorsByCoachId;
  final bool canComment;
  final ValueChanged<WorkoutVideo> onOpenVideo;
  final Future<List<VideoComment>> Function(WorkoutVideo video, String text)
  onAddComment;

  const WorkoutVideoSheet({
    super.key,
    required this.videos,
    required this.commentsByVideoId,
    required this.commentAuthorsByCoachId,
    required this.canComment,
    required this.onOpenVideo,
    required this.onAddComment,
  });

  @override
  State<WorkoutVideoSheet> createState() => _WorkoutVideoSheetState();
}

class _WorkoutVideoSheetState extends State<WorkoutVideoSheet> {
  final Map<int, TextEditingController> _controllers = {};
  late Map<int, List<VideoComment>> _commentsByVideoId;
  int? _savingVideoId;

  @override
  void initState() {
    super.initState();
    _commentsByVideoId = {
      for (final entry in widget.commentsByVideoId.entries)
        entry.key: List<VideoComment>.from(entry.value),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _controllerFor(int videoId) {
    return _controllers.putIfAbsent(videoId, TextEditingController.new);
  }

  Future<void> _saveComment(WorkoutVideo video) async {
    final videoId = video.id;
    if (videoId == null) return;

    final controller = _controllerFor(videoId);
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _savingVideoId = videoId);
    final comments = await widget.onAddComment(video, text);
    if (!mounted) return;
    setState(() {
      _commentsByVideoId[videoId] = comments;
      _savingVideoId = null;
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 22,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Видео подхода',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              if (widget.videos.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: softCardDecoration(context),
                  child: const Text(
                    'К этому подходу пока не прикреплено видео.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                for (final video in widget.videos)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _VideoCard(
                      video: video,
                      comments: _commentsByVideoId[video.id] ?? const [],
                      commentAuthorsByCoachId: widget.commentAuthorsByCoachId,
                      canComment: widget.canComment,
                      controller: _controllerFor(video.id ?? -1),
                      isSaving: _savingVideoId == video.id,
                      onOpenVideo: () => widget.onOpenVideo(video),
                      onSaveComment: () => _saveComment(video),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final WorkoutVideo video;
  final List<VideoComment> comments;
  final Map<int, User> commentAuthorsByCoachId;
  final bool canComment;
  final TextEditingController controller;
  final bool isSaving;
  final VoidCallback onOpenVideo;
  final VoidCallback onSaveComment;

  const _VideoCard({
    required this.video,
    required this.comments,
    required this.commentAuthorsByCoachId,
    required this.canComment,
    required this.controller,
    required this.isSaving,
    required this.onOpenVideo,
    required this.onSaveComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: softCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatWorkoutDateTime(video.uploadedAt),
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onOpenVideo,
              icon: const Icon(Icons.smart_display_rounded),
              label: const Text('Открыть видео'),
              style: primaryButtonStyle(radius: 16),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Комментарии тренера',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (comments.isEmpty)
            const Text(
              'Комментариев пока нет.',
              style: TextStyle(
                color: AppColors.textGrey,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            for (final comment in comments)
              _TrainerCommentRow(
                comment: comment,
                author: commentAuthorsByCoachId[comment.coachId],
              ),
          if (canComment) ...[
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: appInputDecoration('Комментарий к видео'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isSaving ? null : onSaveComment,
                style: primaryButtonStyle(radius: 16),
                child: Text(
                  isSaving ? 'Сохраняем...' : 'Сохранить комментарий',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TrainerCommentRow extends StatelessWidget {
  final VideoComment comment;
  final User? author;

  const _TrainerCommentRow({
    required this.comment,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    final name = author?.name.trim().isNotEmpty == true
        ? author!.name
        : comment.coachName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 58,
            child: Column(
              children: [
                AvatarPreview(
                  imagePath: author?.imagePath,
                  radius: 17,
                  scale: author?.imageScale ?? 1,
                  offsetX: author?.imageOffsetX ?? 0,
                  offsetY: author?.imageOffsetY ?? 0,
                  fallbackText: _initialsFor(name),
                ),
                const SizedBox(height: 5),
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: appFieldColor(context),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                comment.text,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _initialsFor(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'Т';
  final first = parts.first.substring(0, 1);
  final second = parts.length > 1 ? parts[1].substring(0, 1) : '';
  return '$first$second'.toUpperCase();
}
