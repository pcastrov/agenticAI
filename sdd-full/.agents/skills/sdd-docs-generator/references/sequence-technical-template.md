<!--
Diagrama de secuencia TÉCNICO: specs/NNN-[id-nombre-modulo]/diagramas/HU-XX-tecnico.md
Audiencia: desarrollo y QA.
Reglas:
- Mismo flujo que HU-XX-negocio.md, desglosado en las capas de plan.md (sección 1 y 2).
- Los nombres de participantes usan los archivos o componentes reales según `structure` del Perfil técnico.
- Cada llamada relevante cita el RF que implementa; las validaciones citan la propiedad (Px) que protegen.
- Los mismos casos límite del diagrama de negocio aparecen como bloques alt, con su código o tipo de error.
- Participantes: `participant ID as Etiqueta`. El rol (interfaz, servicio, autorización, persistencia) va en la etiqueta, no como icono. `@{ "type": "..." } as Etiqueta` falla en el visor de Cursor: después de `}` espera un salto de línea.
- Sintaxis Mermaid: no uses ";" en los textos (separa instrucciones; escríbelo como #59;), ni la palabra "end" suelta en un mensaje (enciérrala entre paréntesis). El nombre del participante va en una sola línea. No uses `mirrorActors: false` ni `<br/>` en el nombre: el visor calcula el alto del diagrama con esa fila de abajo y, si falta o el texto se sale de la caja, recorta el dibujo aunque al alejar el zoom se vea completo. En los mensajes sí puedes usar `<br/>`.
- Refleja el flujo vigente: se actualiza en su lugar, no se archiva.
- Se visualiza con la vista previa de Markdown de Cursor o VS Code (Ctrl+Shift+V); no requiere extensiones.
-->

# HU-XX — [Nombre del flujo] (técnico)

```mermaid
sequenceDiagram
    autonumber
    actor U as [Rol principal]
    participant UI as Interfaz / API ([controlador o pantalla])
    participant SVC as Dominio / Servicio ([servicio o caso de uso])
    participant AUTH as Autorización ([política o middleware])
    participant DB as Persistencia ([modelo / repositorio])
    participant EXT as [API externa]

    U->>UI: [petición o evento]
    UI->>AUTH: verificar permiso
    alt Sin permiso
        AUTH-->>UI: denegado (RNF-02, PX)
        UI-->>U: [código / mensaje de error]
    else Permitido
        UI->>SVC: [operacion(entrada)] (RF-XX)
        SVC->>SVC: validar reglas de negocio (RN-XX)
        alt Validación falla
            SVC-->>UI: [error de validación]
            UI-->>U: [código / mensaje de error]
        else Válido
            SVC->>DB: BEGIN TRANSACTION
            SVC->>DB: persistir cambios (RF-XX)
            SVC->>EXT: [llamada a la integración]
            alt Integración falla
                EXT-->>SVC: [error / timeout]
                SVC->>DB: ROLLBACK
                SVC-->>UI: [error controlado]
                UI-->>U: [código / mensaje de error]
            else Integración correcta
                EXT-->>SVC: [respuesta]
                SVC->>DB: COMMIT
                SVC-->>UI: [resultado]
                UI-->>U: [respuesta exitosa]
            end
        end
    end
```
