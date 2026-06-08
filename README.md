# GearVision SDD Demo

Demo de spec driven development para una app de administracion de produccion industrial.

El mockup visual de referencia esta publicado en Vercel/v0:

https://v0-machine-administration-app.vercel.app/

La implementacion base usa Flutter Web/Dart para demostrar que el mockup puede guiar producto y diseno sin imponer el stack tecnico.

## SDD

Los steerings viven en `SDD/steering/`.

Las specs viven en `SDD/specs/`.

## Proyecto

- Stack: Flutter Web + Dart.
- Datos: mocks locales en memoria.
- Backend: no aplica para esta demo.

## Comandos

```sh
./scripts/flutter analyze
./scripts/flutter test
./scripts/flutter build web --no-wasm-dry-run
./scripts/flutter run -d chrome
```
