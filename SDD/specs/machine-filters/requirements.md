# Requirements: KAN-5 Filtros de Maquinas

## Ticket

- Jira: `KAN-5`
- Titulo: Agregar filtros de maquinas por estado, operador y turno
- URL: https://alcarazgdavid.atlassian.net/browse/KAN-5

## Contexto

GearVision ya cuenta con un dashboard Flutter Web para visualizar maquinas de produccion de carton usando datos mock locales.
asdasdasdasdasd
El supervisor necesita encontrar maquinas rapidamente durante el turno segun criterios operativos visibles en el dashboard.

## Objetivo

Como supervisor de planta, quiero filtrar la lista de maquinas por estado, operador y turno, para enfocarme en los equipos relevantes sin navegar a otra pantalla.

## Alcance

La funcionalidad debe incluir:

- Controles de filtro visibles en el dashboard.
- Filtro por `Estado`.
- Filtro por `Operador`.
- Filtro por `Turno`.
- Combinacion de filtros.
- Accion para limpiar filtros.
- Estado vacio cuando ningun resultado coincida.
- KPIs calculados sobre el resultado filtrado.
- Datos mock locales en memoria.

Fuera de alcance:

- Backend.
- APIs.
- Base de datos.
- Persistencia remota.
- Autenticacion.
- Autorizacion.
- Busqueda avanzada fuera de los filtros listados.
- Guardar filtros entre sesiones.

## Requisitos Funcionales

### R1. Panel de filtros

El dashboard debe mostrar un panel o bloque de filtros cerca de los KPIs y antes de la lista de maquinas.

El bloque debe ser visible y usable en desktop y mobile.

### R2. Filtro por estado

El usuario debe poder filtrar maquinas por:

- `Todos`
- `Operativa`
- `Mantenimiento`
- `Detenida`

### R3. Filtro por operador

El usuario debe poder filtrar maquinas por:

- `Todos`
- `Sin asignar`
- Cada operador disponible en los datos mock.

### R4. Filtro por turno

El usuario debe poder filtrar maquinas por:

- `Todos`
- `-`
- `A`
- `B`
- `C`

### R5. Combinacion de filtros

Cuando se seleccionen varios filtros, la lista debe mostrar solo maquinas que cumplan todos los criterios activos.

### R6. Limpiar filtros

El usuario debe tener una accion visible para limpiar filtros.

Al limpiar filtros, la lista debe volver a mostrar todas las maquinas.

### R7. KPIs filtrados

Los KPIs de `Operativas`, `Mantenimiento` y `Detenidas` deben calcularse sobre las maquinas visibles despues de aplicar filtros.

Cuando haya filtros activos, la UI debe indicar de forma breve que los KPIs corresponden al resultado filtrado.

### R8. Estado vacio

Si ningun resultado coincide, la UI debe mostrar un estado vacio claro con copy en espanol.

El estado vacio debe permitir limpiar filtros desde una accion visible.

### R9. Datos locales

La funcionalidad debe operar solamente sobre las listas mock locales en memoria.

No debe crear endpoints, clientes HTTP, base de datos, servicios backend ni persistencia remota.

## Requisitos No Funcionales

- Mantener la arquitectura simple y explicable.
- Mantener copy visible en espanol.
- Preservar la direccion visual oscura, industrial y tipo glass del dashboard.
- Evitar dependencias externas nuevas salvo que sean claramente necesarias.
- Mantener controles compactos y legibles.
- Evitar solapamientos de texto, badges, inputs o acciones en mobile.

## Criterios de Aceptacion

- Existe esta spec en `SDD/specs/machine-filters/` con `requirements.md`, `design.md` y `tasks.md`.
- La spec se crea en la branch `codex/spec-machine-filters`.
- El dashboard permite filtrar maquinas por estado.
- El dashboard permite filtrar maquinas por operador.
- El dashboard permite filtrar maquinas por turno.
- Los filtros pueden combinarse.
- Existe una accion para limpiar filtros.
- Si no hay resultados, la UI muestra un estado vacio claro.
- Los KPIs reflejan el resultado filtrado e indican el contexto cuando hay filtros activos.
- La app sigue usando solamente datos mock locales.
- No se agregan endpoints, clientes HTTP, base de datos ni servicios backend.
- `./scripts/flutter analyze` pasa sin issues.
- `./scripts/flutter test` pasa.
