<!--
Diagrama de FLUJO de NEGOCIO (cliente): specs/001-[id-nombre-modulo]/diagramas/HU-XX-negocio.md (ruta real; no uses NNN literal)
Audiencia: cliente / negocio / cualquier persona no técnica.
Reglas:
- Tipo Mermaid: flowchart (TD o LR). NO uses sequenceDiagram aquí.
- Caja negra: el "Sistema" es un paso o grupo de pasos; sin archivos, clases, tablas ni librerías.
- Lenguaje natural (qué ve o decide el usuario / el negocio).
- Decisiones = rombos `{…?}`; cada rama cita el RF o RN que aplica cuando encaje.
- Cada caso límite de la sección 8 de spec.md aparece como rama o nodo de resultado.
- Sintaxis Mermaid: no uses ";" en los textos (escríbelo como #59;); evita la palabra "end" suelta como id de nodo.
- Refleja el flujo vigente: se actualiza en su lugar, no se archiva.
- Se visualiza con la vista previa de Markdown de Cursor o VS Code (Ctrl+Shift+V); no requiere extensiones.
-->

# HU-XX — [Nombre del flujo]

```mermaid
flowchart TD
    Start([Inicio]) --> Accion["[Rol]: [acción que inicia el flujo]"]
    Accion --> Sistema{"Sistema: ¿[condición / validación]?<br/>(RF-XX)"}

    Sistema -->|No / datos inválidos| Rechazo["[Mensaje o resultado que ve el usuario]<br/>(RF-XX)"]
    Sistema -->|Regla de negocio no cumple| Regla["[Motivo del rechazo]<br/>(RN-XX)"]
    Sistema -->|Sí / flujo normal| Ext{"¿Hace falta [sistema externo]?"}

    Ext -->|Sí| Llamada["Sistema solicita [qué] a [externo]"]
    Llamada --> ExtOk{"¿Respuesta correcta?"}
    ExtOk -->|No| FalloExt["[Cómo se informa el fallo]<br/>(RF-XX)"]
    ExtOk -->|Sí| Exito["[Resultado observable para el usuario]<br/>(RF-XX)"]
    Ext -->|No| Exito

    Rechazo --> Fin([Fin])
    Regla --> Fin
    FalloExt --> Fin
    Exito --> Fin
```
