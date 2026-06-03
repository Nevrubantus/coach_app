import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'app_ui.dart';
import 'core/app_colors.dart';
import 'training_formatters.dart';
import 'workout_detail_models.dart';

class SetSheet extends StatefulWidget {
  final String exerciseName;
  final int setIndex;
  final double initialWeight;
  final int initialReps;

  const SetSheet({
    super.key,
    required this.exerciseName,
    required this.setIndex,
    required this.initialWeight,
    required this.initialReps,
  });

  @override
  State<SetSheet> createState() => _SetSheetState();
}

class _SetSheetState extends State<SetSheet> {
  late double _weight;
  late int _reps;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
    _reps = widget.initialReps;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_weight < 0 || _reps <= 0) return;

    Navigator.of(context).pop(
      SetInput(
        weight: _weight,
        reps: _reps,
        notes: _notesController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.exerciseName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.08,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Подход ${widget.setIndex}',
                style: const TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              _NumberStepper(
                label: 'Рабочий вес',
                value: '${formatWeight(_weight)} кг',
                onMinus: () => setState(
                  () => _weight = (_weight - 2.5).clamp(0, 500).toDouble(),
                ),
                onPlus: () => setState(() => _weight += 2.5),
              ),
              const SizedBox(height: 14),
              _NumberStepper(
                label: 'Повторения',
                value: '$_reps',
                onMinus: () => setState(
                  () => _reps = ((_reps - 1).clamp(1, 200) as num).toInt(),
                ),
                onPlus: () => setState(() => _reps += 1),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _notesController,
                minLines: 1,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: appInputDecoration(
                  'Заметка',
                  hint: 'Например: тяжело, легко, боль в плече',
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: primaryButtonStyle(),
                  child: const Text(
                    'Сохранить подход',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
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
}

class _NumberStepper extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _NumberStepper({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: appFieldColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _RoundStepperButton(icon: Icons.remove_rounded, onTap: onMinus),
          const SizedBox(width: 10),
          _RoundStepperButton(icon: Icons.add_rounded, onTap: onPlus),
        ],
      ),
    );
  }
}

class _RoundStepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundStepperButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: ElevatedButton(
        onPressed: onTap,
        style: primaryButtonStyle(
          background: appSurfaceColor(context),
          foreground: AppColors.primaryBlue,
          radius: 18,
        ).copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
        child: Icon(icon, size: 30),
      ),
    );
  }
}
