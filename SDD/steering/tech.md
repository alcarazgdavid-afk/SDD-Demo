# Steering Tecnico

## Stack de Implementacion

La implementacion principal de la demo debe usar Flutter para demostrar que el mockup de Vercel/v0 funciona como referencia visual aunque el producto final use otro lenguaje y framework.

- Lenguaje: Dart.
- Framework: Flutter.
- Target inicial: Flutter Web.
- UI: Material 3 customizado para acercarse al diseno industrial oscuro del mockup.
- Estado: `ChangeNotifier`, `ValueNotifier` o Riverpod solo si la spec lo justifica.
- Datos: mocks locales en Dart.
- Iconos: `lucide_icons_flutter`, Material Icons o paquete equivalente disponible.

## Principios Tecnicos

- No copiar codigo generado por v0/Next.js.
- Traducir la intencion de producto y diseno del mockup a Flutter.
- Mantener la arquitectura simple para que la demo sea rapida de explicar.
- No crear backend, persistencia remota o autenticacion salvo que el usuario cambie explicitamente esta decision.
- Preferir componentes pequenos y legibles sobre abstracciones prematuras.

## Backend

Este proyecto no manejara backend.

Toda la informacion necesaria para la demo debe vivir como datos mock locales dentro de la app. No crear APIs, bases de datos, servicios remotos, autenticacion, autorizacion, sincronizacion externa ni persistencia remota salvo que el usuario cambie explicitamente esta decision.

Si una spec necesita simular datos, debe hacerlo con archivos Dart locales y estado en memoria.

## Calidad Minima

- El codigo debe compilar.
- La UI debe cargar sin errores visibles.
- Las specs deben incluir una forma simple de verificar el resultado.
- Para cambios de UI, validar al menos en desktop y un ancho mobile.

## Datos Mock

Los datos mock deben vivir cerca de la capa de demo, por ejemplo:

- `lib/data/mock_machines.dart`
- `lib/data/mock_operators.dart`

Los mocks deben ser suficientemente realistas para mostrar estados operativos, pero no deben simular reglas de negocio complejas.
