import 'package:flutter/material.dart';

import '../data/mock_machines.dart';
import '../data/mock_operators.dart';
import '../models/machine.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_panel.dart';
import '../widgets/kpi_card.dart';
import '../widgets/machine_card.dart';

class PlantDashboardScreen extends StatefulWidget {
  const PlantDashboardScreen({super.key});

  @override
  State<PlantDashboardScreen> createState() => _PlantDashboardScreenState();
}

class _PlantDashboardScreenState extends State<PlantDashboardScreen> {
  late final List<Machine> _machines = [...mockMachines];

  int _countByStatus(MachineStatus status) {
    return _machines.where((machine) => machine.status == status).length;
  }

  void _updateMachine(String id, Machine Function(Machine machine) update) {
    setState(() {
      final index = _machines.indexWhere((machine) => machine.id == id);
      if (index == -1) return;
      _machines[index] = update(_machines[index]).copyWith(updatedAt: DateTime.now());
    });
  }

  void _showOperators() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Operadores'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final operator in mockOperators)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline, size: 18, color: AppTheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              operator.name,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              operator.role,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundDeep,
              AppTheme.background,
              Color(0xFF053C42),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _HeroHeader(),
                    const SizedBox(height: 30),
                    _ProductionPanel(onOperatorsPressed: _showOperators),
                    const SizedBox(height: 26),
                    _KpiGrid(countByStatus: _countByStatus),
                    const SizedBox(height: 24),
                    _MachineGrid(
                      machines: _machines,
                      onStatusChanged: (machine, status) {
                        _updateMachine(machine.id, (current) => current.copyWith(status: status));
                      },
                      onOperatorChanged: (machine, operatorId) {
                        _updateMachine(
                          machine.id,
                          (current) => current.copyWith(
                            operatorId: operatorId,
                            clearOperator: operatorId == null,
                          ),
                        );
                      },
                      onShiftChanged: (machine, shift) {
                        _updateMachine(machine.id, (current) => current.copyWith(shift: shift));
                      },
                      onProductChanged: (machine, product) {
                        _updateMachine(
                          machine.id,
                          (current) => current.copyWith(productType: product),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return Column(
      crossAxisAlignment: compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'PANEL DE PLANTA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.primary,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 3.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Control de Produccion',
          textAlign: compact ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: AppTheme.primaryText,
            fontSize: compact ? 42 : 58,
            height: 0.98,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Supervisa el estado de tus maquinas de carton y los operadores en turno, en tiempo real.',
            textAlign: compact ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              color: AppTheme.mutedText,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductionPanel extends StatelessWidget {
  const _ProductionPanel({required this.onOperatorsPressed});

  final VoidCallback onOperatorsPressed;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(22),
      borderColor: AppTheme.border.withValues(alpha: 0.95),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 620;
          final title = Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.3),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(Icons.factory_outlined, color: Color(0xFF00272C), size: 28),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Produccion de Carton',
                      style: TextStyle(
                        color: AppTheme.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Estado de maquinas y operadores asignados',
                      style: TextStyle(color: AppTheme.mutedText, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          );

          final operatorsButton = OutlinedButton.icon(
            onPressed: onOperatorsPressed,
            icon: const Icon(Icons.groups_2_outlined, size: 18),
            label: const Text('Operadores'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryText,
              side: BorderSide(color: AppTheme.border.withValues(alpha: 0.9)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title,
                const SizedBox(height: 18),
                operatorsButton,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: title),
              const SizedBox(width: 20),
              operatorsButton,
            ],
          );
        },
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.countByStatus});

  final int Function(MachineStatus status) countByStatus;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 760;
        final cards = MachineStatus.values
            .map((status) => KpiCard(status: status, count: countByStatus(status)))
            .toList();

        if (compact) {
          return Column(
            children: [
              for (final card in cards) ...[
                card,
                if (card != cards.last) const SizedBox(height: 12),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (final card in cards) ...[
              Expanded(child: card),
              if (card != cards.last) const SizedBox(width: 14),
            ],
          ],
        );
      },
    );
  }
}

class _MachineGrid extends StatelessWidget {
  const _MachineGrid({
    required this.machines,
    required this.onStatusChanged,
    required this.onOperatorChanged,
    required this.onShiftChanged,
    required this.onProductChanged,
  });

  final List<Machine> machines;
  final void Function(Machine machine, MachineStatus status) onStatusChanged;
  final void Function(Machine machine, String? operatorId) onOperatorChanged;
  final void Function(Machine machine, String shift) onShiftChanged;
  final void Function(Machine machine, String product) onProductChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900 ? 2 : 1;
        final spacing = columns == 2 ? 18.0 : 14.0;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final machine in machines)
              SizedBox(
                width: columns == 2
                    ? (constraints.maxWidth - spacing) / 2
                    : constraints.maxWidth,
                child: MachineCard(
                  machine: machine,
                  operators: mockOperators,
                  onStatusChanged: (status) => onStatusChanged(machine, status),
                  onOperatorChanged: (operatorId) => onOperatorChanged(machine, operatorId),
                  onShiftChanged: (shift) => onShiftChanged(machine, shift),
                  onProductChanged: (product) => onProductChanged(machine, product),
                ),
              ),
          ],
        );
      },
    );
  }
}
