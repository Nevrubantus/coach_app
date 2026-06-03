import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'training_formatters.dart';

class ChartPoint {
  final DateTime date;
  final double value;

  const ChartPoint({
    required this.date,
    required this.value,
  });
}

class WorkingWeightChart extends StatelessWidget {
  final List<ChartPoint> points;
  final double height;
  final String emptyLabel;

  const WorkingWeightChart({
    super.key,
    required this.points,
    this.height = 160,
    this.emptyLabel = 'Нет сохраненных подходов',
  });

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Container(
        height: height,
        alignment: Alignment.center,
        child: Text(
          emptyLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: height,
          child: CustomPaint(
            painter: _WorkingWeightChartPainter(points),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ChartLabel(point: points.first),
            _ChartLabel(point: points.last),
          ],
        ),
      ],
    );
  }
}

class _ChartLabel extends StatelessWidget {
  final ChartPoint point;

  const _ChartLabel({required this.point});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${formatWeight(point.value)} кг',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 2),
        Text(
          formatShortDate(point.date),
          style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
        ),
      ],
    );
  }
}

class _WorkingWeightChartPainter extends CustomPainter {
  final List<ChartPoint> points;

  _WorkingWeightChartPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final values = points.map((point) => point.value).toList();
    final minValue = values.reduce(math.min);
    final maxValue = values.reduce(math.max);
    final range = math.max(maxValue - minValue, 1);
    const topPadding = 18.0;
    const bottomPadding = 18.0;
    final chartHeight = size.height - topPadding - bottomPadding;

    final gridPaint = Paint()
      ..color = const Color(0xFFEFEFF4)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = AppColors.primaryBlue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotPaint = Paint()..color = AppColors.primaryBlue;
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryBlue.withValues(alpha: 0.16),
          AppColors.primaryBlue.withValues(alpha: 0.01),
        ],
      ).createShader(Offset.zero & size);

    for (var i = 1; i <= 3; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    final fillPath = Path();
    final offsets = <Offset>[];

    for (var i = 0; i < values.length; i++) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * i / (values.length - 1);
      final normalized = (values[i] - minValue) / range;
      final y = topPadding + chartHeight - normalized * chartHeight;
      final point = Offset(x, y);
      offsets.add(point);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
        fillPath.moveTo(point.dx, size.height - bottomPadding);
        fillPath.lineTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
        fillPath.lineTo(point.dx, point.dy);
      }
    }

    fillPath.lineTo(offsets.last.dx, size.height - bottomPadding);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    for (final offset in offsets) {
      canvas.drawCircle(offset, 4, dotPaint);
      canvas.drawCircle(
        offset,
        7,
        Paint()..color = AppColors.primaryBlue.withValues(alpha: 0.12),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WorkingWeightChartPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
