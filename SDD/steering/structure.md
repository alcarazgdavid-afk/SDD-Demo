# Steering de Estructura

## Estructura SDD

Toda la documentacion de spec driven development vive bajo `SDD/`.

```text
SDD/
  steering/
    product.md
    design.md
    tech.md
    structure.md
    spec-process.md
  specs/
    <slug-corto>/
      requirements.md
      design.md
      tasks.md
```

## Estructura Esperada de App Flutter

Cuando se implemente la app, usar una estructura simple:

```text
lib/
  main.dart
  app.dart
  data/
  models/
  screens/
  widgets/
  theme/
```

## Convenciones

- Specs: carpetas en kebab-case, por ejemplo `machine-status-filters`.
- Branches de spec: `codex/spec-<slug-corto>`.
- Archivos Dart: snake_case.
- Clases Dart: PascalCase.
- Widgets compartidos en `lib/widgets/`.
- Pantallas principales en `lib/screens/`.
- Tema visual en `lib/theme/`.

## Limites

- No crear multiples apps o paquetes internos para la demo inicial.
- No introducir estructura de monorepo.
- No mezclar documentos SDD con codigo de aplicacion.
