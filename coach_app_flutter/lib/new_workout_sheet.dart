import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'training_formatters.dart';

class NewWorkoutInput {
  final String title;
  final DateTime scheduledAt;

  const NewWorkoutInput({
    required this.title,
    required this.scheduledAt,
  });
}

class NewWorkoutSheet extends StatefulWidget {
  final DateTime initialDate;

  const NewWorkoutSheet({super.key, required this.initialDate});

  @override
  State<NewWorkoutSheet> createState() => _NewWorkoutSheetState();
}

class _NewWorkoutSheetState extends State<NewWorkoutSheet> {
  final _titleController = TextEditingController(text: 'Новая тренировка');
  late DateTime _scheduledAt;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _scheduledAt = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
      now.hour + 1,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );
    if (date == null) return;

    setState(() {
      _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        _scheduledAt.hour,
        _scheduledAt.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt),
    );
    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(
        _scheduledAt.year,
        _scheduledAt.month,
        _scheduledAt.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submit() {
    final title = _titleController.text.trim();

    Navigator.of(context).pop(
      NewWorkoutInput(
        title: title.isEmpty ? 'Новая тренировка' : title,
        scheduledAt: _scheduledAt,
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
                'Новая тренировка',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: appInputDecoration('Название', context: context),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PickerButton(
                      icon: Icons.calendar_month_rounded,
                      label: formatShortDate(_scheduledAt),
                      onTap: _pickDate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PickerButton(
                      icon: Icons.schedule_rounded,
                      label: formatTime(_scheduledAt),
                      onTap: _pickTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: primaryButtonStyle(),
                  child: const Text(
                    'Создать и добавить упражнения',
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
