import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'core/app_colors.dart';

const appCardRadius = 18.0;

BoxDecoration softCardDecoration(BuildContext context) {
  return BoxDecoration(
    color: appSurfaceColor(context),
    borderRadius: BorderRadius.circular(appCardRadius),
    border: Border.all(color: appBorderColor(context)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: isAppDark(context) ? 0.18 : 0.04),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
    ],
  );
}

Future<T?> showAppBottomSheet<T>(
  BuildContext context,
  Widget child,
) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (_) => child,
  );
}

InputDecoration appInputDecoration(
  String label, {
  BuildContext? context,
  String? hint,
  IconData? icon,
}) {
  final dark = context != null && isAppDark(context);
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: icon == null
        ? null
        : Icon(icon, color: dark ? const Color(0xFFB0B3BD) : Colors.grey),
    filled: true,
    fillColor: context == null
        ? const Color(0xFFF8F9FA)
        : appFieldColor(context),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        color: context == null ? Colors.transparent : appBorderColor(context),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        color: context == null ? Colors.transparent : appBorderColor(context),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
    ),
  );
}

ButtonStyle primaryButtonStyle({
  Color background = AppColors.primaryBlue,
  Color foreground = Colors.white,
  double radius = 20,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: background,
    foregroundColor: foreground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    elevation: 0,
  );
}

class PickerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PickerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: FittedBox(child: Text(label)),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          side: BorderSide(color: appBorderColor(context)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class ServerProblemCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ServerProblemCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: softCardDecoration(context).copyWith(
        color: const Color(0xFFFFF8E8),
        border: Border.all(color: const Color(0xFFFFDFA3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: Color(0xFFB66A00)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
