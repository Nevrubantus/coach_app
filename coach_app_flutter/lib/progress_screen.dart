import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_ui.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'offline_cache.dart';
import 'progress_chart.dart';
import 'server_request.dart';
import 'training_formatters.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<ProgressPoint> _points = [];
  List<BodyWeightEntry> _bodyWeights = [];
  String? _selectedExercise;
  String? _loadError;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      return;
    }

    List<ProgressPoint> points = [];
    List<BodyWeightEntry> bodyWeights = [];
    String? loadError;
    final cachedPoints = await OfflineCache.readProgress(userId);
    final cachedBodyWeights = await OfflineCache.readBodyWeights(userId);

    if (mounted) {
      setState(() {
        _points = cachedPoints;
        _bodyWeights = cachedBodyWeights;
        _selectedExercise = _selectExercise(cachedPoints);
        _isLoading = false;
      });
    }

    try {
      points = await waitForServer(client.training.getProgress(userId, null));
      bodyWeights = await waitForServer(client.user.listBodyWeights(userId));
      await OfflineCache.saveProgress(userId, points);
      await OfflineCache.saveBodyWeights(userId, bodyWeights);
    } catch (_) {
      points = cachedPoints;
      bodyWeights = cachedBodyWeights;
      loadError = 'Сервер не отвечает. Проверь, что Serverpod запущен.';
    }

    if (!mounted) return;
    setState(() {
      _points = points;
      _bodyWeights = bodyWeights;
      _selectedExercise = _selectExercise(points);
      _loadError = loadError;
      _isLoading = false;
    });
  }

  String? _selectExercise(List<ProgressPoint> points) {
    final exercises = _exerciseNames(points);
    if (exercises.contains(_selectedExercise)) return _selectedExercise;
    return exercises.isEmpty ? null : exercises.first;
  }

  List<ProgressPoint> get _selectedPoints {
    final exercise = _selectedExercise;
    if (exercise == null) return const [];
    return _points.where((point) => point.exerciseName == exercise).toList();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _exerciseNames(_points);
    final selectedPoints = _selectedPoints;
    final delta = selectedPoints.length < 2
        ? null
        : selectedPoints.last.weight - selectedPoints.first.weight;

    return RefreshIndicator(
      onRefresh: _loadProgress,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
        children: [
          const Text(
            'График прогресса',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          if (_loadError != null) ...[
            const SizedBox(height: 12),
            ServerProblemCard(message: _loadError!, onRetry: _loadProgress),
          ],
          const SizedBox(height: 20),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            _BodyWeightSection(entries: _bodyWeights),
            const SizedBox(height: 20),
            if (_points.isEmpty)
              const _EmptyProgressCard()
            else ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: exercises
                      .map(
                        (exercise) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(exercise),
                            selected: exercise == _selectedExercise,
                            onSelected: (_) =>
                                setState(() => _selectedExercise = exercise),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                decoration: softCardDecoration(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedExercise ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (delta != null)
                          Text(
                            '${delta >= 0 ? '+' : ''}${formatWeight(delta)} кг',
                            style: TextStyle(
                              color: delta >= 0
                                  ? Colors.green
                                  : Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    WorkingWeightChart(
                      points: selectedPoints
                          .map(
                            (point) => ChartPoint(
                              date: point.date,
                              value: point.weight,
                            ),
                          )
                          .toList(),
                      height: 190,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ...selectedPoints.reversed.map(
                (point) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ProgressPointCard(point: point),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _BodyWeightSection extends StatelessWidget {
  final List<BodyWeightEntry> entries;

  const _BodyWeightSection({required this.entries});

  @override
  Widget build(BuildContext context) {
    final delta = entries.length < 2
        ? null
        : entries.last.weight - entries.first.weight;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: softCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Вес атлета',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              if (delta != null)
                Text(
                  '${delta >= 0 ? '+' : ''}${formatWeight(delta)} кг',
                  style: TextStyle(
                    color: delta <= 0 ? Colors.green : Colors.orange,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          WorkingWeightChart(
            points: entries
                .map(
                  (entry) => ChartPoint(
                    date: entry.measuredAt,
                    value: entry.weight,
                  ),
                )
                .toList(),
            height: 170,
            emptyLabel: 'Вес появится после сохранения профиля',
          ),
        ],
      ),
    );
  }
}

class _ProgressPointCard extends StatelessWidget {
  final ProgressPoint point;

  const _ProgressPointCard({required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: softCardDecoration(context),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              formatShortDate(point.date),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Text(
            '${formatWeight(point.weight)} кг',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _EmptyProgressCard extends StatelessWidget {
  const _EmptyProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: softCardDecoration(context),
      child: const Center(
        child: Text(
          'После первого сохраненного подхода появится график упражнений',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

List<String> _exerciseNames(List<ProgressPoint> points) {
  final names = points.map((point) => point.exerciseName).toSet().toList();
  names.sort();
  return names;
}
