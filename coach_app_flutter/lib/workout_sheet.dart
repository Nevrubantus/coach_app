import 'package:coach_app_client/coach_app_client.dart';
import 'package:flutter/material.dart';

import 'app_ui.dart';
import 'training_formatters.dart';
import 'workout_detail_models.dart';

class WorkoutSheet extends StatefulWidget {
  final Workout workout;

  const WorkoutSheet({super.key, required this.workout});

  @override
  State<WorkoutSheet> createState() => _WorkoutSheetState();
}

class _WorkoutSheetState extends State<WorkoutSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _durationController;
  late final TextEditingController _notesController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.workout.title);
    _durationController = TextEditingController(
      text: widget.workout.durationMinutes?.toString() ?? '',
    );
    _notesController = TextEditingController(text: widget.workout.notes ?? '');
    _selectedDate = widget.workout.scheduledAt.toLocal();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );
    if (date == null) return;

    setState(() {
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        _selectedDate.hour,
        _selectedDate.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    if (time == null) return;

    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submit() {
    Navigator.of(context).pop(
      WorkoutInput(
        title: _titleController.text.trim(),
        scheduledAt: _selectedDate,
        durationMinutes: int.tryParse(_durationController.text.trim()),
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
              const Text(
                'Настройка тренировки',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: appInputDecoration('Название'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PickerButton(
                      icon: Icons.calendar_month_rounded,
                      label: formatShortDate(_selectedDate),
                      onTap: _pickDate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PickerButton(
                      icon: Icons.schedule_rounded,
                      label: formatTime(_selectedDate),
                      onTap: _pickTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: appInputDecoration('Длительность, мин'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _notesController,
                textCapitalization: TextCapitalization.sentences,
                decoration: appInputDecoration('Заметка'),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: primaryButtonStyle(),
                  child: const Text(
                    'Сохранить',
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
