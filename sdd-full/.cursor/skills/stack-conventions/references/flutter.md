---
description: Buenas prácticas y arquitectura idiomática para Flutter y Dart (Views, ViewModels, Repositories, Services)
globs: **/*.dart
alwaysApply: false
---

# Convenciones Flutter & Dart

> Fuente: `.cursor/skills/stack-conventions/references/flutter.md`. Basada en la [guía oficial de arquitectura de Flutter](https://docs.flutter.dev/app-architecture). Las decisiones propias del proyecto (gestor de estado, inyección de dependencias, navegación) van en **Convenciones** de `AGENTS.md` y tienen prioridad. Aplica a código nuevo o modificado.

## 1. Capas
| Capa | Responsabilidad | Ejemplo |
|------|-----------------|---------|
| View (widgets) | Renderizar estado y reenviar eventos | `OrderListScreen` |
| ViewModel / controlador de estado | Estado de la pantalla y comandos | Notifier (Riverpod), Cubit/Bloc, ChangeNotifier |
| Repository | Fuente de verdad: combina servicios, cachea y convierte a modelos de dominio | `OrderRepository` |
| Service | Envoltorio fino de una fuente externa: API HTTP, BD local, plugin | `ApiClient`, `AuthService` |

- **Debe**: Las dependencias van en un solo sentido: View → ViewModel → Repository → Service. Un widget nunca usa un Service ni un Repository directamente.
- **Debe**: Usar el gestor de estado y el mecanismo de inyección que ya tiene el proyecto (providers de Riverpod, `BlocProvider`, `get_it`...). Si no hay uno, preguntar antes de introducirlo.

## 2. Capa de Presentación (Widgets)
- **Debe**: Prohibido ejecutar llamadas HTTP, consultas a BD o lógica de negocio en `build()` o en callbacks (`onPressed`, `onTap`). Los callbacks solo invocan métodos del ViewModel o disparan eventos.
- **Debe**: Los efectos de interfaz (navegar, `showDialog`, SnackBar) se hacen en la capa de vista, reaccionando al estado (`BlocListener`, `ref.listen`, listeners), nunca desde el ViewModel.
- **Debe**: Constructores `const` siempre que sea posible.
- **Preferir**: Extraer bloques de UI a clases `StatelessWidget` en lugar de métodos que retornan widgets (`Widget _buildHeader()`). Es **Debe** cuando el bloque se reutiliza, puede ser `const` o necesita su propio `BuildContext`.
- **Debe**: Liberar en `dispose()` todo `TextEditingController`, `AnimationController`, `ScrollController`, `FocusNode` y `StreamSubscription` creados por el widget.
- **Debe**: Después de un `await`, comprobar `context.mounted` (o `mounted`) antes de usar el `BuildContext`.
- **Debe**: Listas largas con constructores perezosos (`ListView.builder`, `SliverList`) y `Key` estables en listas que cambian de orden.
- **Debe**: Colores, tipografía y espaciados desde `Theme` / tokens del diseño; textos visibles desde localización (l10n), no fijos en el widget.

## 3. Gestión de Estado
- **Debe**: Estado efímero de UI (animaciones, mostrar contraseña, toggles) en `StatefulWidget` o `ValueNotifier`. Toda mutación de datos de negocio vive en el ViewModel.
- **Debe**: Los ViewModels no reciben `BuildContext` ni importan `package:flutter/material.dart` o `widgets.dart`, salvo necesidad justificada.
- **Preferir**: Estados de pantalla explícitos e inmutables (cargando, datos, vacío, error) en lugar de varias banderas booleanas.

## 4. Capa de Datos
- **Debe**: Modelos inmutables (campos `final`, `copyWith`, igualdad por valor). Preferir `freezed` o `json_serializable` si el proyecto los usa.
- **Debe**: El JSON se convierte en `factory Model.fromJson(...)` o código generado, dentro de la capa de datos; nunca se procesa `Map<String, dynamic>` en la vista o el ViewModel.
- **Debe**: Los Services solo envuelven la fuente externa; la lógica de caché, reintentos y mapeo a dominio está en el Repository.
- **Preferir**: Los Repositories devuelven un tipo `Result` (éxito o error) en lugar de lanzar excepciones hacia el ViewModel, como recomienda la guía oficial.
- **Preferir**: Navegación declarativa con `go_router` (o el router que ya use el proyecto).

## 5. Concurrencia y Rendimiento
- **Preferir**: Trabajo síncrono costoso (parseo de JSON grande, procesamiento de imágenes) en un isolate con `Isolate.run()` (o `compute()`), cuando se midan frames perdidos. En web no hay isolates reales y el trabajo sigue en el hilo principal.
- **Debe**: Nada de trabajo pesado dentro de `build()`.

## 6. Tests
- **Debe**: Unit tests de ViewModels y Repositories con dobles (`mocktail` o fakes); widget tests para pantallas con interacción.
- **Preferir**: Fakes de Repository en los widget tests, nunca llamadas reales a red.

## Skills relacionadas
Si están instaladas, úsalas para los procedimientos: `flutter-apply-architecture-best-practices`, `flutter-add-widget-test`, `flutter-implement-json-serialization`, `dart-add-unit-test`, `dart-run-static-analysis`.

## DRY en este stack
- **Duplicación aceptable (no es hallazgo)**: un widget de pantalla y un ViewModel por vista aunque el layout se parezca; modelos de dominio y de API separados aunque compartan campos; árboles de widgets declarativos parecidos entre pantallas.
- **Sí es hallazgo**: la misma lógica de negocio en dos ViewModels; el mismo acceso a datos fuera del Repository; un widget propio con lógica (no solo layout) reimplementado cuando ya existe en `## Código Compartido`.
- **Regla de tres**: un bloque de widgets idéntico en tres o más pantallas se puede consultar para extraerlo a un widget propio; con dos, no.
- **Excluir de la búsqueda**: `.dart_tool/`, `build/`, `*.g.dart`, `*.freezed.dart`, `*.mocks.dart`, `lib/generated/`, `lib/l10n/` generado, y las carpetas de plataforma (`android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/`) salvo código nativo propio.

## Verificación Automática
- **Análisis**: `flutter analyze` con `very_good_analysis` o `flutter_lints` en `analysis_options.yaml`, incluyendo al menos `prefer_const_constructors`, `use_build_context_synchronously`, `avoid_print`, `cancel_subscriptions` y `close_sinks`.
- **Formato**: `dart format --output=none --set-exit-if-changed .`.
- **Arquitectura** (opcional): reglas de capas con herramientas como DCM o `custom_lint`, por ejemplo prohibir imports de `services/` desde `ui/`.
