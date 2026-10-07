# Plan de Diseño Técnico: [Nombre del Módulo]

**Módulo**: `NNN-[id-nombre-modulo]`
**Basado en**: `specs/NNN-[id-nombre-modulo]/spec.md`

---

## 1. Estructura de Módulos y Archivos (Laravel + Filament)
*(Componentes, Modelos y Migraciones a crear/modificar)*

- **Nuevos Archivos**:
  - `database/migrations/YYYY_MM_DD_HHMMSS_create_[tabla]_table.php` -> Esquema de BD.
  - `app/Models/[Modelo].php` -> Eloquent Model, relaciones y casting.
  - `app/Filament/Resources/[Modelo]Resource.php` -> Configuración del Resource de Filament.
  - `app/Filament/Resources/[Modelo]Resource/Pages/` -> Páginas (List, Create, Edit, View).
  - `app/Policies/[Modelo]Policy.php` -> Autorización y permisos.
  - `tests/Feature/Filament/[Modelo]ResourceTest.php` -> Cobertura con Pest PHP / PHPUnit.

- **Archivos Existentes a Modificar**:
  - `app/Providers/Filament/AdminPanelProvider.php` -> Registro de navegación / plugins.

## 2. Contratos y Modelo de Datos

### Migración y Esquema Eloquent
- **Tabla**: `[nombre_tabla]`
  - `id`: `bigIncrements()`
  - `[campo_1]`: `string()`, `nullable()`, etc.
  - `status`: `enum(['borrador', 'publicado', 'archivado'])`
  - `timestamps()` y `softDeletes()`

### Configuración del Formulario y Tabla de Filament
- **Form Schema (`form()`)**:
  - `TextInput::make('[campo_1]')->required()->maxLength(255)`
  - `Select::make('status')->options(...)`
- **Table Columns (`table()`)**:
  - `TextColumn::make('[campo_1]')->searchable()->sortable()`
  - `BadgeColumn::make('status')`
- **Mapeo de RF**: El formulario cubre `RF-01` y la tabla cubre `RF-02`.

## 3. Lógica de Negocio y Actions (Pseudocódigo / PHP)
1. Recibir la solicitud desde la página o acción de Filament (`Form` / `Action`).
2. Validar reglas de negocio adicionales mediante un Custom Action o Hook de Filament (`mutateFormDataBeforeCreate`).
3. Ejecutar la transacción de base de datos via Eloquent (`DB::transaction`).
4. Notificar al usuario mediante `Notification::make()->success()->send()`.

## 4. Decisiones Técnicas Justificadas
- **Decisión 1**: Uso de un Custom Action de Filament en lugar de lógica en el modelo.
  - **Justificación**: Mantiene la lógica de presentación desacoplada y facilita las pruebas.
  - **Alternativa Descartada**: Poner la lógica en observadores (`Observers`), descartado para evitar efectos secundarios ocultos.

## 5. Estrategia de Tests y Trazabilidad
- **Framework de Pruebas**: `php artisan test` (Pest PHP o PHPUnit testing de Livewire/Filament).
- **Cobertura por Requisito**:
  - `RF-01`: Probar que la página de renderizado de Filament carga correctamente (`livewire(ListRecords::class)->assertCanSeeTableRecords()`).
  - `RF-02`: Probar el formulario de creación (`livewire(CreateRecord::class)->fillForm(...)->call('create')->assertHasNoFormErrors()`).
