---
description: Convenciones para apps NativePHP (Laravel de escritorio o móvil) sobre la base de Laravel
globs: app/**/*.php, config/nativephp.php
alwaysApply: false
---

# Convenciones NativePHP

> Fuente: `.cursor/skills/stack-conventions/references/nativephp.md`. Se usa junto con `laravel.md`, que sigue aplicando completo. NativePHP evoluciona rápido: antes de usar una API nativa (ventanas, menús, notificaciones, almacenamiento, cámara...), verifica su firma en la documentación de la versión instalada. No inventes métodos.

## 1. Entorno de Ejecución
- **Debe**: Asumir que la app corre en el equipo del usuario, no en un servidor: base de datos local (normalmente SQLite), sin servicios externos garantizados (Redis, colas de servidor, cron del sistema).
- **Debe**: El código y el `.env` se distribuyen con la app. Nunca incluyas secretos (claves de API privadas, credenciales de servidor); las operaciones sensibles van a un backend propio.
- **Debe**: Diseñar para funcionar sin conexión o degradar con un mensaje claro cuando falta la red.

## 2. Estructura
- **Debe**: Encapsular las APIs nativas (facades de NativePHP) detrás de servicios propios en `app/Services/Native/` (o la convención del proyecto). Las Actions de dominio no llaman a facades nativas directamente.
- **Preferir**: Escuchar los eventos nativos (ventana, menú, sistema) con Listeners delgados que delegan en Actions.
- **Debe**: La configuración de ventanas, menús y arranque vive en el provider de NativePHP del proyecto, no repartida por controladores.

## 3. Datos
- **Debe**: Las migraciones deben ser seguras para ejecutarse en cada actualización de la app en equipos con datos existentes (sin pérdidas, sin depender de un estado previo manual).
- **Preferir**: Trabajo pesado en segundo plano con los mecanismos de cola que soporte la versión instalada, sin bloquear la interfaz.

## 4. Tests
- **Debe**: Las Actions de dominio se prueban sin entorno nativo, sustituyendo los servicios nativos por dobles o fakes.

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: la configuración declarativa de ventanas, menús y atajos por pantalla aunque se parezca; lo generado por el instalador de NativePHP.
- **Sí es hallazgo**: la misma lógica de acceso a una API nativa (archivos, notificaciones, almacenamiento) repetida en varios lugares en lugar de una clase propia que la encapsule.
- **Excluir de la búsqueda**: lo de Laravel, más `nativephp/` y las carpetas de build del empaquetado (`dist/`, `build/`).

## Verificación Automática
- Las mismas herramientas de `laravel.md`.
- Test de arquitectura sugerido:

```php
arch('domain actions do not use native facades')
    ->expect('App\Actions')
    ->not->toUse('Native');
```
