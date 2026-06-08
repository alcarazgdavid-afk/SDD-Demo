# Steering de Diseno

## Referencia Visual

Usar como mockup visual de referencia:

`https://v0-machine-administration-app.vercel.app/`

La implementacion no tiene que usar el mismo framework ni copiar el codigo del mockup. Debe preservar la intencion visual y la experiencia principal.

## Direccion Visual

- Dashboard industrial oscuro, sobrio y operativo.
- Fondo profundo azul/teal con sensacion de panel de control de planta.
- Superficies tipo glass: cards semitransparentes, bordes sutiles y separacion clara.
- Acento principal turquesa para marca, iconos activos y elementos destacados.
- Estados con color funcional:
  - Operativa: verde.
  - Mantenimiento: ambar.
  - Detenida: coral/rojo.
- Evitar una apariencia generica de landing page; la primera pantalla debe sentirse como herramienta usable.

## Layout

- Header/hero compacto con:
  - Eyebrow: `Panel de planta`.
  - Titulo: `Control de Produccion`.
  - Descripcion corta de supervision en tiempo real.
- Bloque de contexto de produccion con icono de fabrica y accion de operadores.
- KPIs en cards compactas para estados de maquina.
- Cards de maquinas con estado visible, campos editables y timestamp de actualizacion.
- Mantener densidad moderada: suficiente informacion para operar, sin saturar.

## Componentes

- Usar iconos claros para acciones y entidades, preferentemente de una libreria estable como Lucide si el stack lo permite.
- Usar badges para estados.
- Usar selects o controles equivalentes para estado, operador y turno.
- Usar inputs compactos para tipo/producto.
- Usar cards solo para entidades o paneles funcionales, no como decoracion excesiva.

## Copy

- UI visible en espanol.
- Texto directo, operativo y corto.
- Evitar copy de marketing.
- Usar terminos consistentes:
  - `Maquina`
  - `Operador`
  - `Turno`
  - `Estado`
  - `Tipo / producto`
  - `Operativa`
  - `Mantenimiento`
  - `Detenida`

## Responsividad

- Desktop: dashboard centrado con ancho maximo, KPIs en fila y maquinas en grid.
- Mobile: una columna, controles legibles y sin texto truncado en botones importantes.
- No permitir solapamientos entre badges, titulos, inputs o acciones.
