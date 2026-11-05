#!/bin/bash
# setup_sdd_full.sh - Instalador de agenticAI SDD-Full (Mac/Linux)
# Uso:
#   bash ruta/a/sdd-full/setup_sdd_full.sh "/ruta/a/tu-proyecto"

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/.agents"

show_project_path_help() {
    echo "Debes indicar la ruta del proyecto donde se instalará el kit (carpeta raíz de TU app, no la del ZIP)."
    echo ""
    echo "Ejemplo:"
    echo '  bash ~/Downloads/agenticAI-main/sdd-full/setup_sdd_full.sh "/Users/tu/mi-proyecto"'
    echo ""
    echo "O con ruta relativa:"
    echo '  bash ./sdd-full/setup_sdd_full.sh "../mi-proyecto"'
}

PROJECT_PATH="${1:-}"
if [ -z "$PROJECT_PATH" ]; then
    show_project_path_help
    exit 1
fi
if [ ! -d "$PROJECT_PATH" ]; then
    echo "[!] No existe la carpeta: $PROJECT_PATH"
    show_project_path_help
    exit 1
fi
cd "$PROJECT_PATH"
PROJECT_PATH="$(pwd)"
echo "Proyecto: $PROJECT_PATH"

echo "Configurando agenticAI SDD-Full..."
echo ""
echo "¿Qué entorno principal vas a utilizar?"
echo "1) Cursor (carpeta .cursor/)"
echo "2) GitHub Copilot (.github/copilot-instructions.md)"
echo "3) Claude Code (CLAUDE.md)"
echo "4) Pi (.agents/ + extensión .pi/extensions/sdd-commands.ts)"
echo "5) OpenCode (nativo en .agents/)"
read -p "Selecciona una opción (1-5): " choice

case $choice in
    1) ROOT=".cursor" ;;
    2|3|4|5) ROOT=".agents" ;;
    *) echo "Opción no válida."; exit 1 ;;
esac

if [ -f "$ROOT/sdd-kit.md" ]; then
    echo "[!] Ya hay una instalación en $PROJECT_PATH/$ROOT/. Para actualizar sin perder tus skills usa /sdd-update en el chat."
    exit 1
fi
mkdir -p "$ROOT"
cp -R "$SRC/." "$ROOT/"
echo "[+] Paquete instalado en $PROJECT_PATH/$ROOT/"
if [ "$choice" = "1" ]; then
    for r in "$ROOT"/rules/*.md; do [ -e "$r" ] && mv "$r" "${r%.md}.mdc"; done
    echo "[+] Reglas convertidas a .mdc (formato de Cursor)."
fi

if [ "$choice" = "1" ]; then RULE_FILE="global-sdd.mdc"; else RULE_FILE="global-sdd.md"; fi
POINTER="Sigue estrictamente la metodología SDD de \`$ROOT/\`: reglas y Triage en \`$ROOT/rules/$RULE_FILE\`, flujos en \`$ROOT/commands/\`, convenciones en \`$ROOT/skills/\`."
case $choice in
    1) echo "[+] Cursor lee $ROOT/ directamente; no se necesita archivo puente." ;;
    2) mkdir -p .github; printf '%s\n' "# Reglas de AgenticAI SDD-Full" "" "$POINTER" > .github/copilot-instructions.md; echo "[+] .github/copilot-instructions.md generado." ;;
    3) printf '%s\n' "# Instrucciones del Repositorio" "" "$POINTER" > CLAUDE.md; echo "[+] CLAUDE.md generado." ;;
    4)
        echo "[+] Pi: $ROOT/ instalado. Generando extensión de slash commands..."
        # Solo Pi: registra cada comando de commands/ como slash command (la lógica sigue en los .md)
        LIST=""
        for c in "$ROOT"/commands/*.md; do
            n="$(basename "$c" .md)"
            if [ -z "$LIST" ]; then LIST="'$n'"; else LIST="$LIST, '$n'"; fi
        done
        mkdir -p .pi/extensions
        cat << 'EOF' > .pi/extensions/sdd-commands.ts
export default function (pi: any) {
  // Comandos del kit SDD (generados desde commands/ al instalar)
  const commands = [__COMMANDS__];

  commands.forEach((cmd) => {
    pi.registerCommand(cmd, {
      description: `Ejecuta el flujo SDD: ${cmd}`,
      handler: async (args: string, ctx: any) => {
        const extra = args?.trim() ? `\n\nContexto adicional del usuario: ${args.trim()}` : '';
        const prompt = `Por favor, lee y ejecuta paso a paso las instrucciones definidas en __ROOT__/commands/${cmd}.md de este repositorio.${extra}`;
        if (ctx.isIdle()) {
          pi.sendUserMessage(prompt);
        } else {
          pi.sendUserMessage(prompt, { deliverAs: 'followUp' });
        }
      }
    });
  });
}
EOF
        sed -i.bak "s|__COMMANDS__|$LIST|; s|__ROOT__|$ROOT|" .pi/extensions/sdd-commands.ts && rm -f .pi/extensions/sdd-commands.ts.bak
        echo "[+] Extensión de Pi generada en .pi/extensions/sdd-commands.ts"
        echo "    Comandos registrados: $LIST"
        ;;
    5)
        # OpenCode: AGENTS.md + opencode.json instructions + .opencode/commands/*.md
        INSTR="$ROOT/rules/global-sdd.md"
        if [ -f opencode.json ] && command -v python3 >/dev/null 2>&1; then
            python3 - "$INSTR" <<'PY'
import json, sys
path = "opencode.json"
instr = sys.argv[1]
with open(path, encoding="utf-8") as f:
    cfg = json.load(f)
lst = list(cfg.get("instructions") or [])
if instr not in lst:
    lst.append(instr)
cfg["instructions"] = lst
with open(path, "w", encoding="utf-8") as f:
    json.dump(cfg, f, indent=2)
    f.write("\n")
PY
        elif [ -f opencode.json ]; then
            echo "[!] Existe opencode.json; añade manualmente a instructions: \"$INSTR\""
        else
            printf '%s\n' '{' '  "$schema": "https://opencode.ai/config.json",' "  \"instructions\": [\"$INSTR\"]" '}' > opencode.json
        fi
        mkdir -p .opencode/commands
        OC_LIST=""
        for c in "$ROOT"/commands/*.md; do
            n="$(basename "$c" .md)"
            if [ -z "$OC_LIST" ]; then OC_LIST="$n"; else OC_LIST="$OC_LIST, $n"; fi
            cat > ".opencode/commands/$n.md" <<EOF
---
description: Ejecuta el flujo SDD: $n
---

Lee y ejecuta paso a paso las instrucciones definidas en $ROOT/commands/$n.md de este repositorio.
Incluye cualquier argumento del usuario: \$ARGUMENTS
EOF
        done
        echo "[+] OpenCode: $ROOT/ + opencode.json instructions → $INSTR"
        echo "[+] Slash commands en .opencode/commands/: $OC_LIST"
        echo "    Tras /sdd-init, el GATE también queda incrustado en AGENTS.md (obligatorio)."
        ;;
esac

REF="$ROOT/skills/stack-conventions/references"
echo ""
echo "=== Configuración de Frameworks (Opcional) ==="
echo "¿Deseas habilitar convenciones de código para algún framework en particular?"
echo "1) Sí, configurar framework"
echo "2) No, saltar este paso (se conservan todas las guías)"
read -p "Elige (1-2): " frame_choice

if [ "$frame_choice" = "1" ] && [ -d "$REF" ]; then
    echo "Frameworks disponibles:"
    echo "1. Laravel (opcional: + Filament / NativePHP)"
    echo "2. Django"
    echo "3. FastAPI"
    echo "4. Flutter"
    read -p "Ingresa el número de tu framework (1-4): " fw_num

    KEEP=""
    case $fw_num in
        1)
            KEEP="laravel.md"
            read -p "¿Usas Filament? (s/N): " f; if [ "$f" = "s" ] || [ "$f" = "S" ]; then KEEP="$KEEP filament.md"; fi
            read -p "¿Usas NativePHP? (s/N): " n; if [ "$n" = "s" ] || [ "$n" = "S" ]; then KEEP="$KEEP nativephp.md"; fi
            ;;
        2) KEEP="django.md" ;;
        3) KEEP="fastapi.md" ;;
        4) KEEP="flutter.md" ;;
        *) echo "[!] Opción no válida. Se conservan todas las guías."; fw_num="" ;;
    esac

    if [ -n "$fw_num" ]; then
        for f in "$REF"/*.md; do
            name="$(basename "$f")"
            case " $KEEP " in *" $name "*) ;; *) rm -f "$f" ;; esac
        done
        echo "[+] Convención conservada: ${KEEP:-ninguna}. Resto eliminado para ahorrar tokens."
    fi
else
    echo "Saltando configuración de frameworks."
fi

echo ""
echo "¡Instalación completada! Siguiente paso: /sdd-init"
echo "Para actualizar usa /sdd-update en el chat (detecta $ROOT/, protege tus skills y no restaura guías que eliminaste)."
