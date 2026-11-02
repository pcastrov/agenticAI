---
description: Convenciones idiomáticas de Django y Django REST Framework (vistas delgadas, Forms/Serializers, QuerySets, servicios, tareas)
globs: **/*.py
alwaysApply: false
---

# Convenciones Django

> Fuente: `.cursor/skills/stack-conventions/references/django.md`. Las decisiones propias del proyecto van en **Convenciones** de `AGENTS.md` y tienen prioridad. Aplica a código nuevo o modificado.

## 1. Responsabilidades y Estructura
- **Debe**: Vistas (FBV, CBV o ViewSets de DRF) delgadas: validan con Form/Serializer, delegan y responden.
- **Debe**: Elegir **un** estilo para la lógica de negocio y anotarlo en `AGENTS.md`; no mezclarlos en el mismo proyecto:
  - **Servicios**: funciones en `[app]/services.py` o `[app]/services/[feature].py` para escrituras, y `selectors.py` para lecturas complejas.
  - **Modelos y managers**: métodos de modelo para reglas de una entidad y QuerySets personalizados para consultas.
  - Si el proyecto no tiene convención previa: servicios para operaciones con varios modelos o efectos, métodos de modelo para reglas de una sola entidad.
- **Debe**: La transacción (`transaction.atomic`) vive en el servicio, no en la vista.
- **Debe**: Signals solo para desacoplar apps de terceros o integraciones transversales; nunca para lógica de negocio principal (esconden el flujo).

## 2. Datos y Validación
- **Debe**: Validar con `Form`/`ModelForm` (vistas HTML) o `Serializer` (DRF).
- **Debe**: Pasar a los servicios `cleaned_data` / `validated_data` o argumentos tipados, nunca `request`.
- **Preferir**: Type hints en servicios y selectores.
- **Debe**: Configuración y secretos desde variables de entorno, nunca en `settings.py` versionado.

## 3. Consultas (Django ORM)
- **Debe**: Evitar N+1: `select_related()` para ForeignKey y OneToOne; `prefetch_related()` (o `Prefetch`) para ManyToMany y relaciones inversas.
- **Debe**: Consultas repetidas o con filtros de negocio en un QuerySet personalizado expuesto con `as_manager()`.
- **Debe**: Sin repositorios que solo envuelven `Model.objects.get()` / `.create()`.
- **Preferir**: `only()` / `values()` cuando se necesitan pocos campos; `iterator()` para volúmenes grandes; `select_for_update()` cuando hay concurrencia sobre el mismo registro.

## 4. Autorización
- **Debe**: Permisos nativos: `permission_classes` en DRF, `PermissionRequiredMixin` / `@permission_required` en vistas, o permisos a nivel de objeto. Nada de chequeos de rol dispersos.

## 5. Efectos Secundarios
- **Preferir**: Correos, notificaciones y APIs externas en tareas en segundo plano: el framework de tasks de Django si la versión instalada lo incluye, o Celery / RQ según el proyecto.
- **Debe**: Encolar con `transaction.on_commit(...)` cuando la tarea depende de datos recién guardados.
- **Debe**: Nunca llamar a una API externa dentro de `transaction.atomic`.
- **Preferir**: Tareas idempotentes.

## 6. Tests
- **Preferir**: pytest-django con factories (`factory_boy`); tests de API con el cliente de DRF.
- **Debe**: En endpoints de listados, fijar el número de consultas con `django_assert_num_queries` (pytest-django) o `assertNumQueries` para detectar N+1.

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: un `ModelAdmin`, serializer, `ModelForm` y ViewSet por modelo aunque se parezcan; `urls.py` y `apps.py` por app; lo generado por `startapp`.
- **Sí es hallazgo**: la misma regla de negocio en dos vistas o servicios; el mismo filtro de queryset reescrito en varios lugares en lugar de un método del `QuerySet`/`Manager`; la misma validación con lógica copiada entre formularios o serializers.
- **Excluir de la búsqueda**: `.venv/`, `venv/`, `*/migrations/`, `staticfiles/`, `media/`, `__pycache__/`.

## Verificación Automática
- **Lint y formato**: ruff (`ruff check . && ruff format --check .`).
- **Tipos**: mypy con `django-stubs` (y `djangorestframework-stubs` si aplica).
- **Arquitectura**: `import-linter` con contratos, por ejemplo que las vistas no importen modelos de otras apps directamente o que `services` no importe `views`.
- **N+1**: tests con número de consultas fijo; opcionalmente `django-zen-queries` para prohibir consultas en plantillas o serializers.
