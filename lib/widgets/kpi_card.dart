import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../theme/app_theme.dart';
import 'glass_panel.dart';
import 'status_badge.dart';

class KpiCard extends StatelessWidget {
  const KpiCard({
    required this.status,
    required this.count,
    super.key,
  });

  final MachineStatus status;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(status);

    return GlassPanel(
      padding: const EdgeInsets.all(18),
      borderColor: AppTheme.border.withValues(alpha: 0.82),
      child: SizedBox(
        height: 52,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const SizedBox(width: 10, height: 10),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    status.pluralLabel,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            Text(
              '$count',
              style: const TextStyle(
                color: AppTheme.primaryText,
                fontSize: 26,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
