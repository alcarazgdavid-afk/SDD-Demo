# Design: KAN-4 Base Flutter Web

## Resumen

Crear una app Flutter Web base que traduzca el mockup de Vercel/v0 a una implementacion Dart/Flutter.

La meta de esta spec es demostrar el flujo SDD: un ticket define la necesidad, los steerings dan contexto, la spec concreta el alcance y la implementacion puede usar un stack distinto al del mockup.

## Steerings Aplicados

- `SDD/steering/product.md`: define el dominio de administracion de produccion industrial.
- `SDD/steering/design.md`: define la direccion visual oscura, industrial y tipo glass.
- `SDD/steering/tech.md`: define Flutter Web/Dart como stack objetivo.
- `SDD/steering/structure.md`: define estructura de carpetas.
- `SDD/steering/spec-process.md`: define branch y forma de spec.

## Referencia Visual

Mockup publicado:

https://v0-machine-administration-app.vercel.app/

Se toma como referencia de producto y UI:

- Panel de planta.
- Control de Produccion.
- Produccion de Carton.
- KPIs por estado.
- Cards de maquinas.
- Paleta oscura con teal/turquesa y estados verde/ambar/coral.

No se toma como referencia tecnica de implementacion.

## Arquitectura Propuesta

Estructura base:

```text
lib/
  main.dart
  app.dart
  data/
    mock_machines.dart
    mock_operators.dart
  models/
    machine.dart
    operator.dart
  screens/
    plant_dashboard_screen.dart
  theme/
    app_theme.dart
  widgets/
    glass_panel.dart
    kpi_card.dart
    machine_card.dart
```

## Modelo de Datos

### Machine

Campos sugeridos:

- `id`
- `name`
- `status`
- `operatorId`
- `shift`
- `productType`
- `updatedAt`

### MachineStatus

Enum:

- `operational`
- `maintenance`
- `stopped`

### PlantOperator

Campos sugeridos:

- `id`
- `name`
- `role`

## Pantalla Principal

`PlantDashboardScreen` debe componer:

1. Header visual:
   - `Panel de planta`.
   - `Control de Produccion`.
   - descripcion corta.
2. Panel de contexto:
   - icono de fabrica o equivalente.
   - titulo `Produccion de Carton`.
   - subtitulo `Estado de maquinas y operadores asignados`.
   - boton/accion visual `Operadores`.
3. KPIs:
   - operativas.
   - mantenimiento.
   - detenidas.
4. Grid/lista de maquinas:
   - cards con borde superior o badge de color por estado.
   - campos compactos para estado, operador, turno y tipo/producto.

## Tema Visual

Colores sugeridos:

- Fondo principal: azul/teal muy oscuro.
- Superficies: azul oscuro semitransparente.
- Bordes: blanco con opacidad baja o teal con opacidad baja.
- Primario: turquesa.
- Operativa: verde.
- Mantenimiento: ambar.
- Detenida: coral/rojo.

Material 3 debe customizarse para evitar apariencia generica.

## Estado

Para esta spec, el estado puede ser local y simple:

- Datos cargados desde listas mock.
- KPIs calculados en memoria.
- No se requiere persistir cambios.
- No se crean APIs, clientes HTTP, bases de datos ni servicios backend.

Si se agregan selects o controles editables, pueden actualizar estado local sin backend.

## Validacion

Validar:

- `flutter analyze` si el SDK esta disponible.
- `flutter test` si hay tests creados.
- `flutter run -d chrome` o equivalente para revision manual.
- Screenshot o revision visual en desktop y mobile.
