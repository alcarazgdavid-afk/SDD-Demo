import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../models/plant_operator.dart';
import '../theme/app_theme.dart';
import 'glass_panel.dart';
import 'status_badge.dart';

class MachineCard extends StatelessWidget {
  const MachineCard({
    required this.machine,
    required this.operators,
    required this.onStatusChanged,
    required this.onOperatorChanged,
    required this.onShiftChanged,
    required this.onProductChanged,
    super.key,
  });

  final Machine machine;
  final List<PlantOperator> operators;
  final ValueChanged<MachineStatus> onStatusChanged;
  final ValueChanged<String?> onOperatorChanged;
  final ValueChanged<String> onShiftChanged;
  final ValueChanged<String> onProductChanged;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      topAccent: statusColor(machine.status),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        machine.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.edit_outlined, size: 16, color: AppTheme.mutedText),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              StatusBadge(status: machine.status),
            ],
          ),
          const SizedBox(height: 26),
          Text('Estado', style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 8),
          _StatusSelect(
            value: machine.status,
            onChanged: onStatusChanged,
          ),
          const SizedBox(height: 18),
          Text('Operador', style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 8),
          _OperatorSelect(
            value: machine.operatorId,
            operators: operators,
            onChanged: onOperatorChanged,
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 420;
              final fields = [
                _LabeledField(
                  label: 'Turno',
                  child: _ShiftSelect(
                    value: machine.shift,
                    onChanged: onShiftChanged,
                  ),
                ),
                _LabeledField(
                  label: 'Tipo / producto',
                  child: TextFormField(
                    initialValue: machine.productType,
                    onChanged: onProductChanged,
                    decoration: const InputDecoration(
                      hintText: 'Ej: Carton corrugado',
                    ),
                  ),
                ),
              ];

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    fields.first,
                    const SizedBox(height: 18),
                    fields.last,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 112, child: fields.first),
                  const SizedBox(width: 18),
                  Expanded(child: fields.last),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(Icons.schedule_outlined, size: 15, color: AppTheme.mutedText),
              const SizedBox(width: 6),
              Text(
                'Actualizada ${_formatUpdatedAt(machine.updatedAt)}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _StatusSelect extends StatelessWidget {
  const _StatusSelect({required this.value, required this.onChanged});

  final MachineStatus value;
  final ValueChanged<MachineStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MachineStatus>(
      initialValue: value,
      items: MachineStatus.values
          .map(
            (status) => DropdownMenuItem(
              value: status,
              child: Text(status.label),
            ),
          )
          .toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }
}

class _OperatorSelect extends StatelessWidget {
  const _OperatorSelect({
    required this.value,
    required this.operators,
    required this.onChanged,
  });

  final String? value;
  final List<PlantOperator> operators;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value ?? 'none',
      items: [
        const DropdownMenuItem(value: 'none', child: Text('Sin asignar')),
        ...operators.map(
          (operator) => DropdownMenuItem(
            value: operator.id,
            child: Text(operator.name),
          ),
        ),
      ],
      onChanged: (next) => onChanged(next == 'none' ? null : next),
    );
  }
}

class _ShiftSelect extends StatelessWidget {
  const _ShiftSelect({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: const [
        DropdownMenuItem(value: '-', child: Text('-')),
        DropdownMenuItem(value: 'A', child: Text('A')),
        DropdownMenuItem(value: 'B', child: Text('B')),
        DropdownMenuItem(value: 'C', child: Text('C')),
      ],
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }
}

String _formatUpdatedAt(DateTime date) {
  final minutes = date.minute.toString().padLeft(2, '0');
  return '${date.day}/${date.month}, ${date.hour}:$minutes';
}
