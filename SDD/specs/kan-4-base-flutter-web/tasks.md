# Tasks: KAN-4 Base Flutter Web

## 1. Preparar Proyecto Flutter

- [x] Crear proyecto Flutter Web en el repo si no existe.
- [x] Confirmar que `lib/main.dart` arranca la app.
- [x] Configurar nombre base de la app como GearVision.

## 2. Crear Estructura Base

- [x] Crear `lib/app.dart`.
- [x] Crear `lib/theme/app_theme.dart`.
- [x] Crear carpetas `data`, `models`, `screens` y `widgets`.

## 3. Modelar Datos Mock

- [x] Crear modelo `Machine`.
- [x] Crear enum `MachineStatus`.
- [x] Crear modelo `PlantOperator`.
- [x] Crear `mock_machines.dart` con al menos 5 maquinas.
- [x] Crear `mock_operators.dart` con al menos 3 operadores.

## 4. Implementar Tema Visual

- [x] Configurar tema oscuro Material 3.
- [x] Definir colores principales: fondo oscuro, turquesa, verde, ambar y coral.
- [x] Crear estilos reutilizables para superficies tipo glass.

## 5. Construir Dashboard

- [x] Crear `PlantDashboardScreen`.
- [x] Agregar header con `Panel de planta`, `Control de Produccion` y descripcion.
- [x] Agregar panel `Produccion de Carton`.
- [x] Agregar KPIs calculados desde mocks.
- [x] Agregar grid/lista de cards de maquinas.

## 6. Componentizar UI

- [x] Crear `GlassPanel`.
- [x] Crear `KpiCard`.
- [x] Crear `MachineCard`.
- [x] Mantener textos y labels en espanol.

## 7. Responsividad

- [x] Ajustar layout desktop con KPIs en fila y maquinas en grid.
- [x] Ajustar layout mobile en una columna.
- [x] Verificar que textos, badges y controles no se solapen.

## 8. Validacion

- [x] Ejecutar `flutter analyze` si Flutter esta disponible.
- [x] Ejecutar `flutter test` si se agregan tests.
- [x] Ejecutar `flutter build web --no-wasm-dry-run` con el SDK local.
- [ ] Confirmar visualmente que la pantalla respeta el mockup de Vercel/v0 como referencia.

## 9. Cierre

- [x] Revisar que no se haya copiado codigo Next.js del mockup.
- [x] Revisar que no se hayan creado endpoints, clientes HTTP, base de datos ni servicios backend.
- [x] Revisar que la spec siga el alcance de `KAN-4`.
- [x] Dejar resumen de validacion en la respuesta final.
