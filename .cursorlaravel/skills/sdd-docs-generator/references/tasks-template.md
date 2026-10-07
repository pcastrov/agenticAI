# Lista de Tareas Ejecutables: [Nombre del Módulo]

**Módulo**: `NNN-[id-nombre-modulo]`
**Ruta**: `specs/NNN-[id-nombre-modulo]/`

---

## Tareas de Implementación (Laravel + Filament)

- [ ] **Tarea T1: Crear migración, modelo Eloquent y Factory**
  - **Cubre**: `RF-01`
  - **Archivos**: `database/migrations/`, `app/Models/[Modelo].php`, `database/factories/[Modelo]Factory.php`
  - **Hecho cuando**: La migración corra limpiamente (`php artisan migrate`) y los tipos/relaciones del modelo compilen sin errores.

- [ ] **Tarea T2: Escribir test de integración del Resource y crear Filament Resource base**
  - **Cubre**: `RF-01`, `RF-02`
  - **Archivos**: `tests/Feature/Filament/[Modelo]ResourceTest.php`, `app/Filament/Resources/[Modelo]Resource.php`
  - **Hecho cuando**: El test de carga del listado y renderizado del Resource de Filament pase en verde usando Pest/PHPUnit.

- [ ] **Tarea T3: Configurar Form Schema, Table Columns y validaciones**
  - **Cubre**: `RF-02`, `RF-03`
  - **Archivos**: `app/Filament/Resources/[Modelo]Resource.php`, `app/Filament/Resources/[Modelo]Resource/Pages/`
  - **Hecho cuando**: Los tests del formulario de creación/edición (`fillForm`, `call('create')`) validen correctamente los campos y pasen en verde.

- [ ] **Tarea T4: Implementar Policy de autorización y Actions personalizadas**
  - **Cubre**: `RF-04`, Casos Límite de `spec.md`
  - **Archivos**: `app/Policies/[Modelo]Policy.php`, Actions de Filament
  - **Hecho cuando**: Los permisos por rol restrinjan las acciones correctamente y las pruebas de casos límite estén en verde.

---

## Histórico / Tareas Completadas
*(Las tareas marcadas con `- [x]` no deben modificarse ni eliminarse al actualizar la especificación)*
