# Steering de Producto

## Contexto

GearVision es una demo de desarrollo guiado por specs para una app de administracion de produccion industrial.

El producto toma como referencia visual el mockup publicado en Vercel/v0:

`https://v0-machine-administration-app.vercel.app/`

Ese mockup representa un panel de planta para supervisar maquinas de produccion de carton, operadores asignados y estados operativos.

## Usuarios

- Supervisor de planta: revisa rapidamente el estado de las maquinas y toma acciones durante el turno.
- Lider de produccion: necesita visibilidad agregada de operacion, mantenimiento y detenciones.
- Operador: puede aparecer como entidad asignable a una maquina o turno.

## Entidades Principales

- Maquina: equipo de produccion con nombre, estado, operador, turno y tipo/producto.
- Operador: persona que puede ser asignada a una maquina.
- Turno: ventana operativa simple para organizar la produccion.
- Estado de maquina: operativa, mantenimiento o detenida.
- Tipo/producto: descripcion corta de lo que procesa la maquina.

## Objetivo del Producto

La app debe permitir entender el estado de la planta en segundos y actualizar datos basicos sin navegar por flujos complejos.

## Alcance de la Demo

- Priorizar lectura rapida, edicion simple y estados visuales claros.
- Usar datos mock locales salvo que una spec pida backend.
- Evitar autenticacion, roles complejos, reportes avanzados o integraciones externas en specs iniciales.
