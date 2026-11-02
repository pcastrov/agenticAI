# SDD Kit

Kit de **Spec-Driven Development (SDD)** para programar con agentes de IA de forma ordenada: primero el **qué**, luego el **cómo**, después TDD y validación.

**Repositorio**: [https://github.com/pcastrov/agenticAI](https://github.com/pcastrov/agenticAI) · **Licencia**: [MIT](LICENSE)

Este repo **no** es una app: son **dos paquetes** listos para copiar a tu proyecto. En la raíz solo viven este README, la licencia y las carpetas de cada edición.

---

## Organización del repositorio

```text
agenticAI/
├── README.md          ← dónde está cada edición y cómo elegir
├── LICENSE
├── sdd-full/          ← SDD Full (Cursor Pro / modelos frontier)
│   ├── README.md
│   ├── .cursor/       ← copia esto si usas Cursor
│   └── .agents/       ← copia esto si usas otro agente
└── sdd-lite/          ← SDD Lite (modelos locales 8B–14B)
    ├── README.md
    ├── .cursor/
    └── .agents/
```

| Edición | Carpeta | Qué copias al proyecto |
|---------|---------|------------------------|
| **Full** | [`sdd-full/`](sdd-full/) | `sdd-full/.cursor/` → `.cursor/` **o** `sdd-full/.agents/` → `.agents/` |
| **Lite** | [`sdd-lite/`](sdd-lite/) | `sdd-lite/.cursor/` → `.cursor/` **o** `sdd-lite/.agents/` → `.agents/` |

**Elige una edición por proyecto.** No mezcles Full y Lite (ni `.cursor` + `.agents` a la vez).

---

## Full vs Lite

| | **SDD Full** (v3.5+) | **SDD Lite** (v1.0+) |
|---|---|---|
| **Carpeta** | [`sdd-full/`](sdd-full/) | [`sdd-lite/`](sdd-lite/) |
| **Para quién** | Cursor Pro / modelos frontier (Claude, GPT, Gemini…) | Modelos **locales** en GPU modestas |
| **Ventana típica** | 128K+ | **32K** (a veces 16K) con **Ollama** |
| **Flujo** | 8 fases, 3 subagentes, diagramas Mermaid, propiedades, QA estricto | 3 pasos: planear → implementar → archivar |
| **Specs** | `spec.md` + `plan.md` + `tasks.md` + `history.md` | `spec.md` unificado + `summary.md` + `history/h-NN.md` (máx 3 shards) |
| **Actualizar** | `/sdd-update` compara `sdd-full/.cursor` (o `.agents`) del clone | `/sdd-update` compara `sdd-lite/.cursor` (o `.agents`) |

### Escenario para el que se midió y diseñó **SDD Lite**

| Pieza | Objetivo |
|-------|----------|
| **Hardware** | GPU de consumo con **~8 GB VRAM** |
| **Runtime** | **Ollama** |
| **Contexto** | **32K** tokens (`num_ctx` ≈ 32768); a veces 16K |
| **Modelos** | **8B–14B** cuantizados que quepan en 8 GB, p. ej. **Qwen 2.5 Coder 14B**, y variantes **9B / 8B** |
| **Cliente (ideal)** | **Pi** (más liviano) · **OpenCode** · VS Code + Copilot/Ollama (más overhead) |

---

## Estimación de tokens (orientativa)

Aprox. en español/Markdown. Solo kit + docs SDD; **no** incluye código leído, historial del chat ni MCPs de terceros.

### Full — turno típico (Laravel + Filament)

| Escenario | Tokens aprox. |
|-----------|----------------|
| Base fija (regla global + `AGENTS.md` limpio, sin Boost guidelines) | **~2.5–3.5K** |
| Implementar 1 tarea (stack ya adjunto) | **~8–11K** |
| Planificar (plantillas + spec/plan) | **~12–16K** |

Con `/mcp-mode code` y chats cortos por tarea, Full 3.5 suele gastar **cerca de la mitad** (o menos) que Full 3.4 con Boost guidelines + MCPs de navegador siempre-on.

### Lite — turno típico (Ollama 32K, p. ej. Qwen 2.5 Coder 14B / 8 GB VRAM)

| Escenario | Tokens aprox. |
|-----------|----------------|
| Turno normal (regla + subagente + guía + `spec.md` + `summary.md`) | **~3.0–3.5K** |
| + 1 shard de historial | **~4.5–5.0K** |

Overhead del cliente (fuera del kit): **Pi** ~1.2–1.8K · **OpenCode** ~3.5–5K · Copilot Agent ~6.5–9K. Reserva ~3–4K para la respuesta. En 8B–14B evita llenar los 32K al tope (~70–75%).

---

## Instalación rápida

### Full
1. Copia `sdd-full/.cursor/` (o `.agents/`) a la raíz de tu proyecto.
2. `/init` → `/sdd`. Actualizar: `/sdd-update`.
3. Guía: [`sdd-full/README.md`](sdd-full/README.md) · [`sdd-full/.cursor/sdd-kit/README.md`](sdd-full/.cursor/sdd-kit/README.md)

### Lite
1. Copia `sdd-lite/.cursor/` (o `.agents/`) a la raíz de tu proyecto.
2. `/init` → `/sdd` → `/implement` → `/sdd-archive`.
3. Guía: [`sdd-lite/README.md`](sdd-lite/README.md)

### Migración si ya tenías Full desde la raíz del repo (antes de `sdd-full/`)
Hasta el PR que introdujo Lite, el paquete Full vivía en `.cursor/` en la **raíz** del clone. Ahora vive en **`sdd-full/.cursor/`**. Primera vez: copia de nuevo desde `sdd-full/.cursor/` (o actualiza la ruta/`source` de `/sdd-update` hacia `…/agenticAI/sdd-full`). Luego `/sdd-update` ya compara `sdd-full/.cursor`.

---

## Tips para gastar menos
1. Un hilo/chat por tarea.
2. Planear con modelo fuerte; implementar con Auto / modelo más barato.
3. `/mcp-mode code` por defecto; `/ui-check` solo para pantallas.
4. Laravel: Boost con MCP y **sin** guidelines largas en `AGENTS.md`.

---

## Mantenimiento de este repo
1. Cambios Full en `sdd-full/.cursor/` → espejo `sdd-full/.agents/`.
2. Cambios Lite en `sdd-lite/.cursor/` → espejo `sdd-lite/.agents/`.
3. Tras publicar: proyectos Full/Lite actualizan con su `/sdd-update` (ruta `sdd-full/…` o `sdd-lite/…`).
