import '../models/machine.dart';

final mockMachines = <Machine>[
  Machine(
    id: 'm-1',
    name: 'Maquina 1',
    status: MachineStatus.stopped,
    operatorId: null,
    shift: '-',
    productType: 'Carton corrugado',
    updatedAt: DateTime(2026, 6, 7, 22, 58),
  ),
  Machine(
    id: 'm-2',
    name: 'Maquina 2',
    status: MachineStatus.stopped,
    operatorId: null,
    shift: '-',
    productType: 'Carton corrugado',
    updatedAt: DateTime(2026, 6, 7, 22, 55),
  ),
  Machine(
    id: 'm-3',
    name: 'Maquina 3',
    status: MachineStatus.operational,
    operatorId: 'op-ana',
    shift: 'A',
    productType: 'Lamina kraft',
    updatedAt: DateTime(2026, 6, 7, 22, 50),
  ),
  Machine(
    id: 'm-4',
    name: 'Maquina 4',
    status: MachineStatus.maintenance,
    operatorId: 'op-luis',
    shift: 'B',
    productType: 'Caja plegadiza',
    updatedAt: DateTime(2026, 6, 7, 22, 47),
  ),
  Machine(
    id: 'm-5',
    name: 'Maquina 5',
    status: MachineStatus.stopped,
    operatorId: 'op-marta',
    shift: 'C',
    productType: 'Separador carton',
    updatedAt: DateTime(2026, 6, 7, 22, 44),
  ),
];
