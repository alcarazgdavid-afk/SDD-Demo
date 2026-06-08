enum MachineStatus {
  operational,
  maintenance,
  stopped,
}

extension MachineStatusLabels on MachineStatus {
  String get label {
    switch (this) {
      case MachineStatus.operational:
        return 'Operativa';
      case MachineStatus.maintenance:
        return 'Mantenimiento';
      case MachineStatus.stopped:
        return 'Detenida';
    }
  }

  String get pluralLabel {
    switch (this) {
      case MachineStatus.operational:
        return 'Operativas';
      case MachineStatus.maintenance:
        return 'Mantenimiento';
      case MachineStatus.stopped:
        return 'Detenidas';
    }
  }
}

class Machine {
  const Machine({
    required this.id,
    required this.name,
    required this.status,
    required this.operatorId,
    required this.shift,
    required this.productType,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final MachineStatus status;
  final String? operatorId;
  final String shift;
  final String productType;
  final DateTime updatedAt;

  Machine copyWith({
    MachineStatus? status,
    String? operatorId,
    bool clearOperator = false,
    String? shift,
    String? productType,
    DateTime? updatedAt,
  }) {
    return Machine(
      id: id,
      name: name,
      status: status ?? this.status,
      operatorId: clearOperator ? null : operatorId ?? this.operatorId,
      shift: shift ?? this.shift,
      productType: productType ?? this.productType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
