import 'package:flutter_test/flutter_test.dart';
import 'package:gearvision/app.dart';

void main() {
  testWidgets('muestra el dashboard de produccion', (tester) async {
    await tester.pumpWidget(const GearVisionApp());

    expect(find.text('PANEL DE PLANTA'), findsOneWidget);
    expect(find.text('Control de Produccion'), findsOneWidget);
    expect(find.text('Produccion de Carton'), findsOneWidget);
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
}
