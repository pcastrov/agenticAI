# Especificación Funcional: [Nombre del Módulo]

**Estado**: Borrador | Aprobado
**Módulo**: `NNN-[id-nombre-modulo]`

---

## 1. Contexto y Objetivo
- **Problema**: [Descripción breve del problema actual o necesidad de negocio]
- **Objetivo**: [Qué resuelve este módulo y cuál es el valor esperado]

## 2. Usuarios e Historias de Usuario
- **Roles Afectados**: [ej. Usuario Final, Administrador, Sistema]
- **Historia 1**: Como [rol], quiero [acción] para [beneficio].
- **Historia 2**: Como [rol], quiero [acción] para [beneficio].

## 3. Requisitos Funcionales (RF)
*(Utilizar notación EARS: CUANDO [disparador], EL SISTEMA DEBE [acción])*

- **RF-01**: CUANDO [evento/disparador], EL SISTEMA DEBE [comportamiento esperado].
- **RF-02**: MIENTRAS [estado], EL SISTEMA DEBE [comportamiento continuo].
- **RF-03**: SI [condición], EL SISTEMA DEBE [comportamiento condicional]; DE LO CONTRARIO, EL SISTEMA DEBE [comportamiento alternativo].

## 4. Requisitos No Funcionales (RNF)
- **RNF-01**: Rendimiento / Tiempo de respuesta esperado.
- **RNF-02**: Seguridad / Autorización.
- **RNF-03**: Compatibilidad o límites de uso.

## 5. Casos Límite y Manejo de Errores
- **Caso 1**: [Entrada vacía / Estado no encontrado / Falla de red].
  - **Comportamiento Esperado**: [Cómo responde el sistema de forma segura].
- **Caso 2**: [Límite de capacidad / Timeout].
  - **Comportamiento Esperado**: [Mensaje de error claro o fallback].

## 6. Fuera de Alcance (Out of Scope)
- [Funcionalidad A que NO se incluye en esta versión]
- [Integración B que se posterga para un módulo futuro]

## 7. Criterios de Finalización (Definition of Done)
- [ ] Todos los `RF-x` cuentan con pruebas automatizadas en verde.
- [ ] La especificación está validada sin ambigüedades pendientes.
- [ ] Dudas abiertas iniciales marcadas como resueltas.
