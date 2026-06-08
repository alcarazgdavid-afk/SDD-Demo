import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final MachineStatus status;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(status);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          status.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

Color statusColor(MachineStatus status) {
  switch (status) {
    case MachineStatus.operational:
      return AppTheme.operational;
    case MachineStatus.maintenance:
      return AppTheme.maintenance;
    case MachineStatus.stopped:
      return AppTheme.stopped;
  }
}
