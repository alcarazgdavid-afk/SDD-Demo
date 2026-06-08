import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gearvision/app.dart';

Future<void> selectDropdownOption(
  WidgetTester tester,
  Key dropdownKey,
  String option,
) async {
  await tester.ensureVisible(find.byKey(dropdownKey));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(dropdownKey));
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text(option).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text(option).last);
  await tester.pumpAndSettle();
}

Future<void> tapByKey(WidgetTester tester, Key key) async {
  await tester.ensureVisible(find.byKey(key));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('muestra el dashboard de produccion', (tester) async {
    await tester.pumpWidget(const GearVisionApp());

    expect(find.text('PANEL DE PLANTA'), findsOneWidget);
    expect(find.text('Control de Produccion'), findsOneWidget);
    expect(find.text('Produccion de Carton'), findsOneWidget);
    expect(find.text('Filtros de maquinas'), findsOneWidget);
    expect(find.text('Operativas'), findsOneWidget);
    expect(find.text('Mantenimiento'), findsWidgets);
    expect(find.text('Detenidas'), findsOneWidget);
    expect(find.text('Maquina 1'), findsOneWidget);

    await tester.tap(find.text('Operadores'));
    await tester.pumpAndSettle();

    expect(find.text('Cerrar'), findsOneWidget);
    expect(find.text('Ana Robles'), findsWidgets);
    expect(find.text('Luis Torres'), findsWidgets);
    expect(find.text('Marta Solis'), findsWidgets);
  });

  testWidgets('filtra maquinas por estado y limpia filtros', (tester) async {
    await tester.pumpWidget(const GearVisionApp());

    expect(find.text('Maquina 1'), findsOneWidget);
    expect(find.text('Maquina 3'), findsOneWidget);

    await selectDropdownOption(tester, const Key('status-filter'), 'Operativa');

    expect(find.text('KPIs del resultado filtrado'), findsOneWidget);
    expect(find.text('Maquina 1'), findsNothing);
    expect(find.text('Maquina 3'), findsOneWidget);

    await tapByKey(tester, const Key('clear-filters-button'));

    expect(find.text('KPIs del resultado filtrado'), findsNothing);
    expect(find.text('Maquina 1'), findsOneWidget);
    expect(find.text('Maquina 3'), findsOneWidget);
  });

  testWidgets('filtra por operador sin asignar y por turno', (tester) async {
    await tester.pumpWidget(const GearVisionApp());

    await selectDropdownOption(
      tester,
      const Key('operator-filter'),
      'Sin asignar',
    );

    expect(find.text('Maquina 1'), findsOneWidget);
    expect(find.text('Maquina 2'), findsOneWidget);
    expect(find.text('Maquina 3'), findsNothing);

    await tapByKey(tester, const Key('clear-filters-button'));
    await selectDropdownOption(tester, const Key('shift-filter'), 'B');

    expect(find.text('Maquina 4'), findsOneWidget);
    expect(find.text('Maquina 1'), findsNothing);
  });

  testWidgets('muestra estado vacio cuando no hay coincidencias', (
    tester,
  ) async {
    await tester.pumpWidget(const GearVisionApp());

    await selectDropdownOption(tester, const Key('status-filter'), 'Operativa');
    await selectDropdownOption(
      tester,
      const Key('operator-filter'),
      'Sin asignar',
    );

    expect(find.text('No hay maquinas con esos filtros.'), findsOneWidget);
    expect(find.text('Maquina 3'), findsNothing);

    await tapByKey(tester, const Key('empty-clear-filters-button'));

    expect(find.text('No hay maquinas con esos filtros.'), findsNothing);
    expect(find.text('Maquina 3'), findsOneWidget);
  });
}
