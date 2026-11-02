---
name: on-demand-tools
description: Recetas CLI bajo demanda (Playwright, Chrome DevTools, Boost/artisan) sin cargar MCP en el system prompt. Usar solo cuando la tarea toca UI, consola del navegador, esquema BD o docs.
---

# On-demand tools (Lite)

**0 tokens en reposo.** Lee esta skill solo si la tarea pide UI/`ui_check`, consola, schema o docs.

## Cuándo
| Necesidad | Qué usar |
|-----------|----------|
| Backend / lógica | No abras navegador. Artisan/`pest`/Boost CLI según stack. |
| UI visible | Playwright o DevTools CLI → veredicto corto. |
| Schema / docs Laravel | `php artisan` / MCP Boost **solo ese turno**, o Search Docs. |

## Playwright (ejemplo)
```bash
npx playwright test --grep "nombre" # o script del proyecto
# Preferir salida filtrada; no pegar HTML completo al chat
```

## Chrome DevTools CLI
Usa la skill/CLI del entorno (`chrome-devtools-cli`) para screenshot/consola. Resume en ≤5 líneas.

## Laravel Boost / artisan
```bash
php artisan route:list
php artisan db:show   # o schema del proyecto
# Search Docs: solo si MCP Boost está activo en este turno
```

## Regla de fallo
Si UI/test falla → STOP + reporte. No cambies selectores “para que pase” sin aprobación.
