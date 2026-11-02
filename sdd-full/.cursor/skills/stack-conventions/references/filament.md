---
description: Convenciones idiomáticas de Filament 5 (Resources como orquestadores, Schemas, Actions de dominio, Policies, tests con TestAction)
globs: app/Filament/**/*.php, app/Providers/Filament/**/*.php
alwaysApply: false
---

# Convenciones Filament 5

> Fuente: `.cursor/skills/stack-conventions/references/filament.md`. Se usa junto con `laravel.md`. Las decisiones propias del proyecto van en **Convenciones** de `AGENTS.md`.
>
> **Versión objetivo: Filament 5.x** (requiere PHP 8.2+, Laravel 11.28+, Livewire 4 y Tailwind CSS 4). Su API es la de Filament 4: no uses patrones de Filament 3 (`Form $form`, `Infolist $infolist`, `Tables\Actions\*`, `->actions()` / `->bulkActions()` en tablas). Ante la duda, verifica en https://filamentphp.com/docs/5.x. Si el proyecto usa otra versión mayor, indícalo en `AGENTS.md` y no apliques esta guía sin revisarla.

## 1. Estructura de un Resource
- **Debe**: Respetar la estructura que genera `php artisan make:filament-resource`:

```text
app/Filament/Resources/Customers/
├── CustomerResource.php
├── Pages/            # CreateCustomer, EditCustomer, ListCustomers (componentes Livewire)
├── Schemas/          # CustomerForm (y CustomerInfolist si hay vista)
└── Tables/           # CustomersTable
```

- **Debe**: El Resource delega: `form(Schema $schema): Schema` llama a `CustomerForm::configure($schema)` y `table(Table $table): Table` a `CustomersTable::configure($table)`. No definas esquemas largos dentro del Resource.
- **Debe**: Formularios e infolists se construyen con `Filament\Schemas\Schema` y `$schema->components([...])`. Los campos están en `Filament\Forms\Components` y los componentes de layout (`Section`, `Grid`, `Tabs`, `Wizard\Step`) en `Filament\Schemas\Components`.
- **Preferir**: Campos reutilizados entre el formulario y un wizard se exponen como métodos estáticos de la clase de `Schemas/` (ej. `CustomerForm::getNameFormField()`).

## 2. Responsabilidades
- **Debe**: Resources, Pages, Schemas, Tables, Widgets y Relation Managers son orquestadores: declaran UI. La lógica de negocio vive en `app/Actions` (ver `laravel.md`).
- **Debe**: No confundir conceptos. Una *Action de Filament* (`Filament\Actions\Action`, espacio de nombres único para páginas, tablas y schemas) es un botón o modal; una *Action de dominio* (`app/Actions`) es la lógica. La de Filament llama a la de dominio:

```php
use App\Actions\Orders\ApproveOrderAction;
use Filament\Actions\Action;

Action::make('approve')
    ->requiresConfirmation()
    ->authorize('approve')
    ->action(fn (Order $record) => app(ApproveOrderAction::class)($record));
```

- **Debe**: Cuando crear o editar implica más que guardar el formulario, sobrescribe `handleRecordCreation(array $data): Model` / `handleRecordUpdate(Model $record, array $data): Model` en la Page y delega en la Action de dominio. `mutateFormDataBeforeCreate()` / `mutateFormDataBeforeSave()` solo para ajustes simples de datos; los hooks (`beforeCreate()`, `afterCreate()`...) no contienen lógica de negocio, solo la invocan.
- **Debe**: En tablas, las acciones por registro van en `->recordActions([...])` y las masivas o de cabecera en `->toolbarActions([...])` (ej. `BulkActionGroup`, `DeleteBulkAction`).

## 3. Validación
- **Debe**: Se valida en el esquema (`->required()`, `->maxLength()`, `->email()`, `->unique()`, `->rules([...])`), no con `FormRequest`. Si la misma regla aplica en una API y en Filament, extráela a una Rule de Laravel o a la Action de dominio para no duplicarla.
- **Preferir**: `->live()` solo en campos que realmente cambian otros campos; usa `->live(onBlur: true)` para texto, para evitar peticiones de Livewire en cada tecla.

## 4. Consultas
- **Debe**: Evitar N+1 en tablas: carga relaciones con `->modifyQueryUsing(fn (Builder $query) => $query->with([...]))` en la clase de `Tables/`, o sobrescribiendo `getEloquentQuery()` en el Resource cuando aplica también a páginas y búsqueda global.
- **Debe**: Columnas de agregados con `->counts()` / `->sum()` / `->avg()`, no con closures que consultan por fila.
- **Preferir**: Los filtros con reglas de negocio reutilizan los Query Scopes del modelo.

## 5. Autorización
- **Debe**: Filament respeta las Policies del modelo (`viewAny`, `view`, `create`, `update`, `delete`, `restore`, `forceDelete`...). Todo Resource tiene su Policy; las acciones personalizadas usan `->authorize('habilidad')` o `->visible()` basados en la Policy, no condicionales de rol sueltos.

## 6. Interfaz
- **Preferir**: Íconos con el enum `Filament\Support\Icons\Heroicon` (ej. `Heroicon::OutlinedUsers`) en lugar de strings.
- **Debe**: Los temas personalizados usan Tailwind CSS 4 (configuración en CSS, sin `tailwind.config.js` heredado de Filament 3).
- **Debe**: El código Livewire propio (páginas personalizadas, componentes) sigue las convenciones de Livewire 4.

## 7. Tests
- **Debe**: Probar cada Page como componente Livewire con Pest y factories: `livewire(ListCustomers::class)->assertOk()->assertCanSeeTableRecords($records)`; crear con `fillForm([...])->call('create')->assertHasNoFormErrors()` o `->assertNotified()`; editar con `call('save')`; estado con `assertSchemaStateSet([...])`.
- **Debe**: Acciones con `callAction(...)`, usando `Filament\Actions\Testing\TestAction` para acciones de tabla, masivas o de schema (ej. `TestAction::make(DeleteBulkAction::class)->table()->bulk()`).
- **Debe**: Probar la autorización: un usuario sin permiso no ve ni ejecuta la Resource o la acción.
- **Preferir**: En paneles múltiples o multi-tenant, fijar el panel con `Filament::setCurrentPanel('id')` (y `Filament::bootCurrentPanel()` tras `Filament::setTenant(...)`).

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: una tabla, un formulario y un infolist por Resource aunque se parezcan (ej. `ClienteResource` y `VendedorResource` con columnas `nombre` y `email`); columnas, filtros y acciones declarativas repetidas entre Resources; las páginas `List`/`Create`/`Edit` que genera `make:filament-resource`.
- **Sí es hallazgo**: la misma lógica dentro de un `->action()`, `->state()` o `->query()` en varios Resources (debe ir a una Action o scope); la misma Rule de validación con lógica copiada; un componente, columna o acción propia reimplementada cuando ya existe una en `## Código Compartido`.
- **Regla de tres**: un grupo de campos o columnas idéntico en tres o más Resources se puede consultar para extraerlo a un método estático o componente propio; con dos, no.
- **Excluir de la búsqueda**: lo de Laravel, más `resources/views/vendor/filament*` y los assets publicados de Filament.

## Verificación Automática
- Las mismas herramientas de `laravel.md` (Pint, Larastan, tests de arquitectura).
- Tests de arquitectura sugeridos:

```php
arch('filament does not query the database directly')
    ->expect('App\Filament')
    ->not->toUse('Illuminate\Support\Facades\DB');

arch('no filament 3 table actions')
    ->expect('App\Filament')
    ->not->toUse('Filament\Tables\Actions');
```

- Para migrar un proyecto desde Filament 4: `composer require filament/upgrade:"~5.0" -W --dev` y `vendor/bin/filament-v5` (en PowerShell usa `~` en lugar de `^`).
