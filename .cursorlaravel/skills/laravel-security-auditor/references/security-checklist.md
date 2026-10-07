# Lista de Verificación de Seguridad para Laravel & Filament PHP

## 1. Autorización y Políticas (BOLA / IDOR)
- **Filament Resources**: Cada `Resource` tiene su `Policy` correspondiente en `app/Policies/` y la registra en `AuthServiceProvider` o la deduce Laravel.
- **Páginas y Actions**: Las acciones de Filament (`Action::make()`) evalúan la condición `visible()` o `disabled()` según permisos del usuario.
- **Consultas Scoped**: Búsquedas en formularios y tablas filtran por el inquilino o usuario activo (`Tenant` / `auth()->user()`) para evitar IDOR.

## 2. Inyección SQL (SQLi) y Consultas Raw
- **Bindings Parametrizados**: Toda consulta raw (`DB::raw`, `whereRaw`, `orderByRaw`) utiliza arreglos de bindings `?` en lugar de interpolar cadenas con `$request`.
- **Filtros Seguros**: Las columnas y búsquedas en tablas de Filament aprovechan el generador de consultas nativo de Eloquent.

## 3. Asignación Masiva y Validaciones
- **Atributos `$fillable`**: Definición explícita de campos permitidos en los Modelos Eloquent para evitar sobreescritura de campos privilegiados (`is_admin`, `role_id`).
- **Validación de Entradas**: Validación de datos de usuario mediante Form Requests o el esquema del formulario en Filament (`required()`, `rules()`, `exists()`).

## 4. Cross-Site Scripting (XSS) y CSRF
- **Escape de Salidas**: Uso de `{{ $variable }}` en Blade. Evitar `{!! $variable !!}` salvo cuando el texto esté explícitamente saneado.
- **Campos HTML / RichEditor**: Sanitización de entradas recibidas a través de `RichEditor` o columnas con `TextColumn::make()->html()`.
- **Protección CSRF**: Inclusión de directivas `@csrf` en formularios y verificación del middleware `VerifyCsrfToken`.

## 5. Carga de Archivos (File Uploads / Prevención de RCE)
- **Validación de MIME/Extensión**: Restricción estricta en campos de archivo (`mimes:png,jpg,pdf`, `max:10240`).
- **Almacenamiento Fuera de Webroot**: Los archivos subidos por usuarios no se guardan en carpetas públicas ejecutables; se usa el disco `local` o `s3` y se sirven mediante rutas con control de acceso.

## 6. Configuración, Entorno y Rate Limiting
- **Variables de Entorno**: `APP_DEBUG=false` en staging/producción y verificación de la clave `APP_KEY`.
- **Ajustes de Sesión**: Cookies configuradas con `session.secure = true` y `session.same_site = lax`.
- **Rate Limiting**: Aplicación de middlewares de limitación (`throttle:6,1`) en endpoints críticos de autenticación, recuperación de credenciales y APIs.

## 7. Manejo de Secretos y Cifrado
- **Cero Credenciales Hardcodeadas**: Ausencia de tokens o claves en código fuente; uso exclusivo de `config()` derivado de `.env`.
- **Protección de Atributos**: Inclusión de atributos sensibles (`password`, `remember_token`) dentro del arreglo `$hidden` de los Modelos.
- **Cifrado de Datos**: Uso del Facade `Hash::make()` para claves y `Crypt` para datos sensibles persistidos en base de datos.