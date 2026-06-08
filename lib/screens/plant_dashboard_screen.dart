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

  MachineStatus? _statusFilter;
  String? _operatorFilter;
  String? _shiftFilter;

  static const _unassignedOperatorFilter = 'none';

  bool get _hasActiveFilters {
    return _statusFilter != null ||
        _operatorFilter != null ||
        _shiftFilter != null;
  }

  List<Machine> get _filteredMachines {
    return _machines.where((machine) {
      final statusMatches =
          _statusFilter == null || machine.status == _statusFilter;
      final operatorMatches = switch (_operatorFilter) {
        null => true,
        _unassignedOperatorFilter => machine.operatorId == null,
        final operatorId => machine.operatorId == operatorId,
      };
      final shiftMatches =
          _shiftFilter == null || machine.shift == _shiftFilter;

      return statusMatches && operatorMatches && shiftMatches;
    }).toList();
  }

  int _countByStatus(MachineStatus status) {
    return _filteredMachines
        .where((machine) => machine.status == status)
        .length;
  }

  void _clearFilters() {
    setState(() {
      _statusFilter = null;
      _operatorFilter = null;
      _shiftFilter = null;
    });
  }

  void _updateMachine(String id, Machine Function(Machine machine) update) {
    setState(() {
      final index = _machines.indexWhere((machine) => machine.id == id);
      if (index == -1) return;
      _machines[index] = update(
        _machines[index],
      ).copyWith(updatedAt: DateTime.now());
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
                      const Icon(
                        Icons.person_outline,
                        size: 18,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              operator.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
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
    final filteredMachines = _filteredMachines;

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
                    _MachineFiltersPanel(
                      statusFilter: _statusFilter,
                      operatorFilter: _operatorFilter,
                      shiftFilter: _shiftFilter,
                      hasActiveFilters: _hasActiveFilters,
                      onStatusChanged: (status) {
                        setState(() => _statusFilter = status);
                      },
                      onOperatorChanged: (operatorId) {
                        setState(() => _operatorFilter = operatorId);
                      },
                      onShiftChanged: (shift) {
                        setState(() => _shiftFilter = shift);
                      },
                      onClearFilters: _clearFilters,
                    ),
                    const SizedBox(height: 24),
                    _KpiGrid(
                      countByStatus: _countByStatus,
                      hasActiveFilters: _hasActiveFilters,
                    ),
                    const SizedBox(height: 24),
                    if (filteredMachines.isEmpty)
                      _EmptyMachineResults(onClearFilters: _clearFilters)
                    else
                      _MachineGrid(
                        machines: filteredMachines,
                        onStatusChanged: (machine, status) {
                          _updateMachine(
                            machine.id,
                            (current) => current.copyWith(status: status),
                          );
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
                          _updateMachine(
                            machine.id,
                            (current) => current.copyWith(shift: shift),
                          );
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

class _MachineFiltersPanel extends StatelessWidget {
  const _MachineFiltersPanel({
    required this.statusFilter,
    required this.operatorFilter,
    required this.shiftFilter,
    required this.hasActiveFilters,
    required this.onStatusChanged,
    required this.onOperatorChanged,
    required this.onShiftChanged,
    required this.onClearFilters,
  });

  final MachineStatus? statusFilter;
  final String? operatorFilter;
  final String? shiftFilter;
  final bool hasActiveFilters;
  final ValueChanged<MachineStatus?> onStatusChanged;
  final ValueChanged<String?> onOperatorChanged;
  final ValueChanged<String?> onShiftChanged;
  final VoidCallback onClearFilters;

  static const _allValue = 'all';
  static const _unassignedValue =
      _PlantDashboardScreenState._unassignedOperatorFilter;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(20),
      borderColor: AppTheme.border.withValues(alpha: 0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 620;
              final title = Column(
                crossAxisAlignment: compact
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filtros de maquinas',
                    textAlign: compact ? TextAlign.center : TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Refina la vista por estado, operador o turno.',
                    style: TextStyle(
                      color: AppTheme.mutedText,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              );

              final clearButton = OutlinedButton.icon(
                key: const Key('clear-filters-button'),
                onPressed: hasActiveFilters ? onClearFilters : null,
                icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
                label: const Text('Limpiar filtros'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryText,
                  disabledForegroundColor: AppTheme.mutedText.withValues(
                    alpha: 0.5,
                  ),
                  side: BorderSide(
                    color: AppTheme.border.withValues(alpha: 0.9),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                ),
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [title, const SizedBox(height: 14), clearButton],
                );
              }

              return Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(width: 16),
                  clearButton,
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;
              final controls = [
                _FilterField(
                  label: 'Estado',
                  child: DropdownButtonFormField<MachineStatus?>(
                    key: const Key('status-filter'),
                    initialValue: statusFilter,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todos')),
                      ...MachineStatus.values.map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status.label),
                        ),
                      ),
                    ],
                    onChanged: onStatusChanged,
                  ),
                ),
                _FilterField(
                  label: 'Operador',
                  child: DropdownButtonFormField<String>(
                    key: const Key('operator-filter'),
                    initialValue: operatorFilter ?? _allValue,
                    items: [
                      const DropdownMenuItem(
                        value: _allValue,
                        child: Text('Todos'),
                      ),
                      const DropdownMenuItem(
                        value: _unassignedValue,
                        child: Text('Sin asignar'),
                      ),
                      ...mockOperators.map(
                        (operator) => DropdownMenuItem(
                          value: operator.id,
                          child: Text(operator.name),
                        ),
                      ),
                    ],
                    onChanged: (next) {
                      onOperatorChanged(next == _allValue ? null : next);
                    },
                  ),
                ),
                _FilterField(
                  label: 'Turno',
                  child: DropdownButtonFormField<String>(
                    key: const Key('shift-filter'),
                    initialValue: shiftFilter ?? _allValue,
                    items: const [
                      DropdownMenuItem(value: _allValue, child: Text('Todos')),
                      DropdownMenuItem(value: '-', child: Text('-')),
                      DropdownMenuItem(value: 'A', child: Text('A')),
                      DropdownMenuItem(value: 'B', child: Text('B')),
                      DropdownMenuItem(value: 'C', child: Text('C')),
                    ],
                    onChanged: (next) {
                      onShiftChanged(next == _allValue ? null : next);
                    },
                  ),
                ),
              ];

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final control in controls) ...[
                      control,
                      if (control != controls.last) const SizedBox(height: 14),
                    ],
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final control in controls) ...[
                    Expanded(child: control),
                    if (control != controls.last) const SizedBox(width: 14),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterField extends StatelessWidget {
  const _FilterField({required this.label, required this.child});

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

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return Column(
      crossAxisAlignment: compact
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
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
                  child: Icon(
                    Icons.factory_outlined,
                    color: Color(0xFF00272C),
                    size: 28,
                  ),
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
              children: [title, const SizedBox(height: 18), operatorsButton],
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
  const _KpiGrid({required this.countByStatus, required this.hasActiveFilters});

  final int Function(MachineStatus status) countByStatus;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 760;
        final cards = MachineStatus.values
            .map(
              (status) => KpiCard(status: status, count: countByStatus(status)),
            )
            .toList();

        final kpis = compact
            ? Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    if (card != cards.last) const SizedBox(height: 12),
                  ],
                ],
              )
            : Row(
                children: [
                  for (final card in cards) ...[
                    Expanded(child: card),
                    if (card != cards.last) const SizedBox(width: 14),
                  ],
                ],
              );

        if (!hasActiveFilters) return kpis;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                  color: AppTheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'KPIs del resultado filtrado',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            kpis,
          ],
        );
      },
    );
  }
}

class _EmptyMachineResults extends StatelessWidget {
  const _EmptyMachineResults({required this.onClearFilters});

  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(24),
      borderColor: AppTheme.border.withValues(alpha: 0.9),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppTheme.backgroundDeep.withValues(alpha: 0.42),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppTheme.border.withValues(alpha: 0.72),
              ),
            ),
            child: const SizedBox(
              width: 54,
              height: 54,
              child: Icon(
                Icons.search_off_outlined,
                color: AppTheme.primary,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay maquinas con esos filtros.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          const Text(
            'Ajusta los criterios o limpia los filtros para ver toda la planta.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.mutedText,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            key: const Key('empty-clear-filters-button'),
            onPressed: onClearFilters,
            icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
            label: const Text('Limpiar filtros'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryText,
              side: BorderSide(color: AppTheme.border.withValues(alpha: 0.9)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            ),
          ),
        ],
      ),
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
                  onOperatorChanged: (operatorId) =>
                      onOperatorChanged(machine, operatorId),
                  onShiftChanged: (shift) => onShiftChanged(machine, shift),
                  onProductChanged: (product) =>
                      onProductChanged(machine, product),
                ),
              ),
          ],
        );
      },
    );
  }
}
