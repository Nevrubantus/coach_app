import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'exercise_image.dart';
import 'main.dart';
import 'offline_cache.dart';
import 'server_request.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  final bool selectionMode;

  const ExerciseLibraryScreen({
    super.key,
    this.selectionMode = false,
  });

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  final _searchController = TextEditingController();
  List<Exercise> _exercises = [];
  String? _loadError;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _loadExercises();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    List<Exercise> exercises = [];
    String? loadError;
    final cachedExercises = await OfflineCache.readExercises();

    if (mounted) {
      setState(() {
        _exercises = cachedExercises;
        _isLoading = false;
      });
    }

    try {
      exercises = await waitForServer(client.training.listExercises());
      await OfflineCache.saveExercises(exercises);
    } catch (_) {
      exercises = cachedExercises;
      loadError = 'Сервер не отвечает. Проверь, что Serverpod запущен.';
    }

    if (!mounted) return;
    setState(() {
      _exercises = exercises;
      _loadError = loadError;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredExercises = _exercises
        .where((exercise) => exercise.name.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Библиотека упражнений',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadExercises,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Поиск упражнения',
                prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_loadError != null) ...[
              ServerProblemCard(message: _loadError!, onRetry: _loadExercises),
              const SizedBox(height: 16),
            ],
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (filteredExercises.isEmpty)
              const _EmptyExerciseList()
            else
              ...filteredExercises.map(
                (exercise) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ExerciseTile(
                    exercise: exercise,
                    selectionMode: widget.selectionMode,
                    onTechniqueTap: () =>
                        showExerciseTechniqueDialog(context, exercise),
                    onSelect: () => Navigator.of(context).pop(exercise),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final bool selectionMode;
  final VoidCallback onTechniqueTap;
  final VoidCallback onSelect;

  const _ExerciseTile({
    required this.exercise,
    required this.selectionMode,
    required this.onTechniqueTap,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: selectionMode ? onSelect : onTechniqueTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEDEDF2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              ExerciseImage(
                exercise: exercise,
                width: 92,
                height: 92,
                borderRadius: BorderRadius.circular(16),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exercise.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 44,
                height: 44,
                child: IconButton.filledTonal(
                  tooltip: selectionMode ? 'Добавить' : 'Техника',
                  onPressed: selectionMode ? onSelect : onTechniqueTap,
                  icon: Icon(
                    selectionMode
                        ? Icons.add_rounded
                        : Icons.play_arrow_rounded,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyExerciseList extends StatelessWidget {
  const _EmptyExerciseList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: Text(
          'Ничего не найдено',
          style: TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

Future<void> showExerciseTechniqueDialog(
  BuildContext context,
  Exercise exercise,
) {
  return showAppBottomSheet<void>(
    context,
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ExerciseImage(
                exercise: exercise,
                width: 320,
                height: 320,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              exercise.description,
              style: const TextStyle(color: Colors.black87, height: 1.35),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: primaryButtonStyle(radius: 16),
                child: const Text(
                  'Понятно',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
