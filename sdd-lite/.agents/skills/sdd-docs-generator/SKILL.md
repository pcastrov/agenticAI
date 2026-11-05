---
name: sdd-docs-generator
description: Plantillas SDD Lite (spec tabular, índice de historial, shard de dominio). Usar al editar specs/ en edición lite.
---

# SDD Docs Generator (Lite)

Lee solo la plantilla necesaria en `references/`:
- `spec-template.md` — spec activo tabular con Few-Shot (máx ~150 líneas)
- `history-index-template.md` — tabla dominio → shard (máx 30 líneas)
- `domain-shard-template.md` — ficha atómica por dominio, solo endpoints y contratos JSON (máx 100 líneas)

Idioma: español. IDs estables. Al cerrar: ficha en `history/<dominio>.md` + 1 fila en `history/index.md`.

**Nomenclatura**: carpeta real `specs/001-<id-kebab>/` (siguiente número libre). Al copiar plantillas, sustituye placeholders; 🚫 no crees `NNN-...` literal.
