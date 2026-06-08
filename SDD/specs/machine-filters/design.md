# Design: KAN-5 Filtros de Maquinas

## Resumen

Agregar una capa de filtrado local al dashboard de GearVision para que el supervisor pueda reducir la lista de maquinas por estado, operador y turno.

La solucion debe mantenerse pequena: estado local en `PlantDashboardScreen`, filtros calculados en memoria y UI compacta dentro del dashboard existente.

## Steerings Aplicados

- `SDD/steering/product.md`: prioriza lectura rapida del estado de planta y datos mock locales.
- `SDD/steering/design.md`: define dashboard oscuro, industrial, tipo glass, con controles compactos y copy operativo.
- `SDD/steering/tech.md`: define Flutter Web/Dart, estado simple local y ausencia de backend.
- `SDD/steering/structure.md`: mantiene pantallas en `lib/screens/` y widgets compartidos en `lib/widgets/`.
- `SDD/steering/spec-process.md`: exige branch nueva y spec bajo `SDD/specs/<slug-corto>/`.

## Decisiones de Producto

Los KPIs se calcularan sobre las maquinas visibles despues de aplicar filtros.

Motivo: cuando el supervisor filtra por operador o turno, los KPIs deben responder a esa vista de trabajo y ayudarle a interpretar el subconjunto seleccionado.

Cuando existan filtros activos, se mostrara un texto breve como `KPIs del resultado filtrado` para evitar ambiguedad.

## Referencia Visual

El mockup de Vercel/v0 sigue siendo referencia visual:

https://v0-machine-administration-app.vercel.app/

La implementacion no debe copiar codigo ni introducir dependencias del stack Next.js. Solo debe preservar la intencion de dashboard industrial usable.

## Arquitectura Propuesta

La implementacion puede vivir principalmente en:

```text
lib/screens/plant_dashboard_screen.dart
lib/widgets/
```

Cambios sugeridos:

- Agregar estado local para filtros en `_PlantDashboardScreenState`.
- Calcular una lista `filteredMachines` desde `_machines`.
- Pasar `filteredMachines` a `_KpiGrid` y `_MachineGrid`.
- Agregar un widget compacto para controles de filtro, por ejemplo `_MachineFiltersPanel`.
- Agregar un widget de estado vacio, por ejemplo `_EmptyMachineResults`.

No se requiere cambiar los modelos si los campos existentes cubren:

- `Machine.status`
- `Machine.operatorId`
- `Machine.shift`

## Estado de Filtros

Estado sugerido:

```text
MachineStatus? _statusFilter
String? _operatorFilter
String? _shiftFilter
```

Convenciones sugeridas:

- `null` significa `Todos` para estado, operador y turno.
- Un valor especial como `none` puede representar `Sin asignar` en operador.

## Logica de Filtrado

La lista filtrada debe aplicar todos los criterios activos:

1. Si hay filtro de estado, `machine.status` debe coincidir.
2. Si hay filtro de operador:
   - `none` debe coincidir con `operatorId == null`.
   - cualquier otro valor debe coincidir con `operatorId`.
3. Si hay filtro de turno, `machine.shift` debe coincidir.

## UI Propuesta

Ubicar los filtros entre el panel `Produccion de Carton` y los KPIs, o entre KPIs y grid si visualmente queda mas claro.

El panel debe usar la direccion actual:

- Superficie tipo `GlassPanel`.
- Labels cortos en espanol.
- Selects para `Estado`, `Operador` y `Turno`.
- Boton secundario `Limpiar filtros`.

Copy sugerido:

- Titulo: `Filtros de maquinas`
- Texto contextual: `Refina la vista por estado, operador o turno.`
- Indicador activo: `KPIs del resultado filtrado`
- Estado vacio: `No hay maquinas con esos filtros.`
- Accion vacia: `Limpiar filtros`

## Responsividad

Desktop:

- Filtros en una fila o grid compacto.
- Accion de limpiar alineada con los controles.
- KPIs en fila como hoy.
- Maquinas en grid.

Mobile:

- Filtros en una columna.
- Inputs y selects de ancho completo.
- Boton de limpiar de ancho completo o claramente accesible.
- Estado vacio sin solapamientos.

## Accesibilidad y Ergonomia

- Cada control debe tener label visible.
- Los textos de opciones deben ser cortos y consistentes con steerings.
- La accion de limpiar filtros debe ser accesible sin depender solo de color.
- El estado vacio debe explicar el resultado y ofrecer recuperacion inmediata.

## Validacion

Validar:

- Filtro por cada estado.
- Filtro por operador asignado y `Sin asignar`.
- Filtro por turno `A`, `B`, `C` y `-`.
- Combinacion de al menos dos filtros.
- Accion para limpiar filtros.
- Estado vacio.
- KPIs con y sin filtros activos.
- `./scripts/flutter analyze`.
- `./scripts/flutter test`.
- Revision visual basica en desktop y mobile.
