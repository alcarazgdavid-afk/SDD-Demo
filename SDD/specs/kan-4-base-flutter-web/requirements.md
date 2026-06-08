# Requirements: KAN-4 Base Flutter Web

## Ticket

- Jira: `KAN-4`
- Titulo: Crear proyecto base Flutter Web desde mockup de Vercel
- URL: https://alcarazgdavid.atlassian.net/browse/KAN-4

## Contexto

Crear el proyecto base de GearVision como demo SDD usando Flutter Web/Dart.

El mockup de Vercel/v0 se usa solo como referencia visual:

https://v0-machine-administration-app.vercel.app/

La implementacion no debe copiar codigo de Next.js ni quedar limitada por el stack del mockup.

## Objetivo

Como supervisor de planta, quiero abrir una app web que muestre el estado de produccion de carton con maquinas, operadores y estados, para entender rapidamente la situacion de la planta durante el turno.

## Alcance

La primera version debe incluir:

- Proyecto Flutter Web base.
- Tema oscuro industrial inspirado en el mockup.
- Pantalla principal de dashboard.
- Datos mock locales para maquinas y operadores.
- UI y documentacion en espanol.
- Layout legible en desktop y mobile.

Fuera de alcance:

- Backend.
- APIs.
- Base de datos.
- Autenticacion.
- Autorizacion.
- Persistencia remota.
- Sincronizacion externa.
- Roles y permisos.
- Reportes avanzados.
- Integraciones externas.

## Requisitos Funcionales

### R1. Proyecto base

El sistema debe tener una app Flutter Web que compile y arranque desde la estructura base del repo.

### R2. Dashboard principal

La app debe mostrar una primera pantalla con:

- Eyebrow `Panel de planta`.
- Titulo `Control de Produccion`.
- Descripcion corta sobre supervision en tiempo real.
- Bloque de contexto `Produccion de Carton`.

### R3. KPIs operativos

La app debe mostrar KPIs para los estados:

- `Operativas`
- `Mantenimiento`
- `Detenidas`

Los totales deben calcularse desde datos mock locales.

### R4. Cards de maquinas

La app debe mostrar una lista o grid de maquinas con:

- Nombre de maquina.
- Badge de estado.
- Estado actual.
- Operador asignado o `Sin asignar`.
- Turno.
- Tipo / producto.
- Timestamp simple de actualizacion.

### R5. Datos mock

La app debe usar datos mock locales definidos en Dart para maquinas y operadores.

La app no debe depender de APIs, base de datos, servicios remotos ni almacenamiento persistente.

### R6. Responsividad

La pantalla debe ser legible en:

- Desktop.
- Mobile.

No debe haber solapamientos entre textos, badges, inputs o acciones principales.

## Requisitos No Funcionales

- Mantener arquitectura simple y facil de explicar.
- Priorizar claridad visual sobre funcionalidad avanzada.
- Usar componentes pequenos y legibles.
- Evitar dependencias externas salvo que ayuden claramente al demo.
- Mantener toda la informacion de demo en memoria o archivos mock locales.

## Criterios de Aceptacion

- Existe estructura Flutter base con `lib/main.dart`.
- La app compila para web.
- El dashboard principal aparece al abrir la app.
- Los KPIs reflejan los datos mock.
- Hay al menos 5 maquinas mock con estados variados.
- Hay al menos 3 operadores mock.
- La UI respeta la direccion visual oscura, industrial y tipo glass definida en `SDD/steering/design.md`.
- No hay codigo copiado del proyecto Next.js generado por v0.
- No existen endpoints, clientes HTTP, configuracion de base de datos ni servicios backend.
- La validacion incluye ejecucion local y revision visual basica en desktop/mobile.
