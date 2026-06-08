# Steering del Proceso SDD

## Flujo Base

Para cada ticket o feature:

1. Crear una branch nueva.
2. Crear una carpeta de spec en `SDD/specs/<slug-corto>/`.
3. Escribir `requirements.md`.
4. Escribir `design.md`.
5. Escribir `tasks.md`.
6. Revisar que la spec sea pequena y ejecutable.
7. Implementar solo cuando el usuario lo pida.

## Branching

Al iniciar una spec nueva, siempre crear una branch antes de crear o editar archivos de spec.

Formato:

```text
codex/spec-<slug-corto>
```

Ejemplo:

```text
codex/spec-machine-status-filters
```

No continuar trabajo de spec en `main` salvo que el usuario lo pida explicitamente.

## Forma de Cada Spec

Cada spec debe tener tres documentos:

```text
requirements.md
design.md
tasks.md
```

### requirements.md

- Explica el problema y el resultado esperado.
- Usa criterios verificables.
- Mantiene el alcance corto.

### design.md

- Describe la solucion propuesta.
- Conecta con los steerings de producto, diseno y tecnologia.
- Menciona decisiones visuales relevantes si aplica.

### tasks.md

- Lista tareas pequenas y accionables.
- Debe poder ejecutarse de arriba hacia abajo.
- Incluye validacion minima al final.

## Reglas de Demo

- Mantener cada spec lo bastante pequena para explicarse en minutos.
- Evitar dependencias externas innecesarias.
- Priorizar trazabilidad: ticket -> spec -> tareas -> implementacion.
- Si el mockup de Vercel inspira la UI, decirlo como referencia visual, no como fuente tecnica.
