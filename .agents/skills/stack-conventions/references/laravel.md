---
description: Convenciones idiomáticas de Laravel (controladores delgados, Actions, FormRequest, Eloquent, colas)
globs: app/**/*.php, routes/**/*.php, database/**/*.php, config/**/*.php, tests/**/*.php
alwaysApply: false
---

# Convenciones Laravel

> Fuente: `.agents/skills/stack-conventions/references/laravel.md`. Las decisiones propias del proyecto van en la sección **Convenciones** de `AGENTS.md` y tienen prioridad sobre esta guía. Aplica a código nuevo o modificado.

## 1. Responsabilidades y Estructura
- **Debe**: Controladores delgados. Solo reciben el `FormRequest`, delegan en una Action o en el modelo y devuelven la respuesta. Sin lógica de negocio, cálculos ni varias consultas.
- **Debe**: Extraer a una Action de propósito único cuando hay transacción, varios modelos, una regla de negocio o reutilización (controlador, comando, job, Filament):
  - Ubicación `app/Actions/[Dominio]/[Verbo][Sustantivo]Action.php` (ej. `CreateOrderAction`).
  - Un único método público: `__invoke()` o `handle()`, según use el proyecto (si no hay convención previa, `__invoke()`).
  - Dependencias por constructor; se invoca resuelta desde el contenedor.
  - La transacción (`DB::transaction`) vive dentro de la Action, no en el controlador.
- **Preferir**: Un CRUD simple (crear/actualizar un modelo con datos validados) puede quedarse en el controlador; no crees una Action que solo llama a `Model::create()`.
- **Debe**: Rutas solo declaran rutas; nada de closures con lógica en `routes/`.
- **Preferir**: Enums nativos de PHP (con cast en el modelo) para estados y tipos, en lugar de strings sueltos.

## 2. Datos y Validación
- **Debe**: `FormRequest` dedicado para cualquier entrada no trivial; no uses `$request->validate()` inline en flujos medianos o grandes.
- **Debe**: Pasar a la Action `$request->validated()` o un DTO tipado, nunca el `Request` completo.
- **Preferir**: API Resources (`JsonResource`) para dar forma a las respuestas JSON en lugar de devolver modelos crudos.
- **Debe**: `env()` solo dentro de `config/`; en el código usa `config()`.

## 3. Consultas y Persistencia (Eloquent)
- **Debe**: Evitar N+1 con `with()` / `load()`; usa `withCount()` / `withSum()` para agregados.
- **Debe**: Activar `Model::preventLazyLoading(! app()->isProduction())` en `AppServiceProvider` para que el N+1 falle en desarrollo y tests.
- **Debe**: Consultas repetidas o con filtros de negocio en Query Scopes del modelo.
- **Debe**: Sin repositorios que solo envuelven `Model::find()` / `Model::create()`.
- **Preferir**: `chunk()`, `lazy()` o `cursor()` para procesar volúmenes grandes.

## 4. Autorización
- **Debe**: Policies (o Gates) para autorizar; se invocan con `authorize()` en el `FormRequest`, `$this->authorize()`/`Gate` o middleware `can:`. Nada de `if ($user->role === ...)` disperso.

## 5. Efectos Secundarios
- **Preferir**: Notificaciones, correos y llamadas a APIs externas en Jobs o Notifications con `ShouldQueue`.
- **Debe**: Los jobs o eventos que dependen de datos recién guardados se despachan después del commit (`afterCommit()` o `after_commit` en la conexión de cola).
- **Debe**: Nunca llamar a una API externa dentro de `DB::transaction`.
- **Preferir**: Jobs idempotentes (reintentar no duplica efectos); usa `ShouldBeUnique` cuando aplique.
- **Preferir**: Events/Listeners solo cuando hay varios consumidores desacoplados; un log o una sola acción no necesita un evento.

## 6. Tests
- **Debe**: Factories para crear datos; sin inserts manuales.
- **Preferir**: Pest (o PHPUnit si es lo que usa el proyecto), tests de feature para endpoints y unitarios para Actions con reglas de negocio.
- **Preferir**: `Queue::fake()`, `Notification::fake()`, `Http::fake()` para verificar efectos sin ejecutarlos.

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: un `FormRequest` por endpoint aunque las reglas se parezcan; un controlador, Policy, Resource de API y Factory por modelo; rutas, migraciones y casts parecidos entre modelos; lo generado por `php artisan make:*` sin lógica propia.
- **Sí es hallazgo**: la misma regla de negocio en dos Actions o servicios; el mismo scope de consulta reescrito con `where()` en varios lugares; la misma validación con lógica (closure o regla custom) copiada en lugar de una Rule.
- **Excluir de la búsqueda**: `vendor/`, `bootstrap/cache/`, `storage/`, `database/migrations/`, `config/` publicado por paquetes, `lang/vendor/`, `resources/views/vendor/`, `public/build/`.

## Verificación Automática
- **Formato**: Laravel Pint (`vendor/bin/pint --test`).
- **Análisis estático**: Larastan (`vendor/bin/phpstan analyse`), nivel acordado en `AGENTS.md`.
- **Tests de arquitectura (Pest)**, por ejemplo:

```php
arch()->preset()->laravel();

arch('controllers do not query the database directly')
    ->expect('App\Http\Controllers')
    ->not->toUse('Illuminate\Support\Facades\DB');

arch('actions use the Action suffix')
    ->expect('App\Actions')
    ->toHaveSuffix('Action');
```

- **N+1**: `preventLazyLoading` activo hace fallar los tests que disparan carga perezosa.
## 7. Laravel Boost (agente)
- **Preferir**: Con Laravel, `/init` y `/retrofit` proponen e instalan [Laravel Boost](https://laravel.com/docs/boost) (`composer require laravel/boost --dev` + `php artisan boost:install`). Aporta MCP (`laravel-boost`) con **Search Docs** (documentación de los paquetes instalados), inspección de la app, esquema de BD y guidelines/skills en `.agents/`.
- **Debe** (cuando Boost está instalado): ante dudas de API o de paquetes del ecosistema (Laravel, Filament, Livewire, Pest…), usa la herramienta MCP **Search Docs** antes de inventar métodos o firmas. En `/retrofit`, usa además Application Info y Database Schema para mapear lo existente sin inventar.
- Boost no forma parte del paquete SDD; vive en el proyecto. Sus guidelines van en el bloque `<laravel-boost-guidelines>` de `AGENTS.md` y no sustituyen el `## Perfil técnico` ni las guías de `stack-conventions`.
