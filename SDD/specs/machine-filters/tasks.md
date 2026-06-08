# Tasks: KAN-5 Filtros de Maquinas

## 1. Preparar Rama y Spec

- [x] Crear branch `codex/spec-machine-filters`.
- [x] Crear carpeta `SDD/specs/machine-filters/`.
- [x] Crear `requirements.md`.
- [x] Crear `design.md`.
- [x] Crear `tasks.md`.

## 2. Revisar Estado Actual

- [x] Confirmar campos disponibles en `Machine`.
- [x] Confirmar operadores disponibles en `mock_operators.dart`.
- [x] Confirmar turnos disponibles en `mock_machines.dart`.
- [x] Revisar ubicacion actual de KPIs y grid en `PlantDashboardScreen`.

## 3. Modelar Estado de Filtros

- [x] Agregar estado local para filtro de estado.
- [x] Agregar estado local para filtro de operador.
- [x] Agregar estado local para filtro de turno.
- [x] Agregar helper para saber si hay filtros activos.

## 4. Implementar Filtrado en Memoria

- [x] Crear calculo de maquinas filtradas desde `_machines`.
- [x] Aplicar filtro por estado.
- [x] Aplicar filtro por operador, incluyendo `Sin asignar`.
- [x] Aplicar filtro por turno.
- [x] Mantener actualizaciones de maquinas sobre la lista base `_machines`.

## 5. Agregar UI de Filtros

- [x] Crear panel visual `Filtros de maquinas`.
- [x] Agregar select de `Estado`.
- [x] Agregar select de `Operador`.
- [x] Agregar select de `Turno`.
- [x] Agregar accion `Limpiar filtros`.
- [x] Adaptar layout para desktop y mobile.

## 6. Actualizar KPIs y Grid

- [x] Calcular KPIs sobre maquinas filtradas.
- [x] Mostrar indicador breve cuando los KPIs sean de resultado filtrado.
- [x] Pasar maquinas filtradas al grid.
- [x] Confirmar que ediciones de maquinas respetan el filtro activo.

## 7. Agregar Estado Vacio

- [x] Mostrar estado vacio cuando no haya maquinas filtradas.
- [x] Incluir copy claro en espanol.
- [x] Incluir accion para limpiar filtros desde el estado vacio.
- [x] Confirmar que el estado vacio no rompe mobile.

## 8. Validacion Funcional

- [x] Probar filtro por estado.
- [x] Probar filtro por operador.
- [x] Probar filtro por operador `Sin asignar`.
- [x] Probar filtro por turno.
- [x] Probar combinacion de filtros.
- [x] Probar limpiar filtros.
- [x] Probar estado vacio.

## 9. Validacion Tecnica

- [x] Ejecutar `./scripts/flutter analyze`.
- [x] Ejecutar `./scripts/flutter test`.
- [ ] Revisar visualmente desktop.
- [ ] Revisar visualmente mobile.
- [x] Confirmar que no se agregaron endpoints, clientes HTTP, base de datos ni servicios backend.

## 10. Cierre

- [x] Revisar que la implementacion siga el alcance de `KAN-5`.
- [x] Revisar que la UI visible este en espanol.
- [ ] Dejar resumen de validacion en la respuesta final.
