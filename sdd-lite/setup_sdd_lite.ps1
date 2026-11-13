# setup_sdd_lite.ps1 - Instalador de agenticAI SDD-Lite (Windows PowerShell)
# Uso:
#   powershell -ExecutionPolicy Bypass -File ruta\a\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\ruta\a\tu-proyecto"
# Texto sin tildes a proposito (compatibilidad con PowerShell 5.1).

param(
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$ProjectPath
)

$ErrorActionPreference = 'Stop'
$EditionLabel = 'SDD-Lite'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$src = Join-Path $ScriptDir '.agents'

function Show-ProjectPathHelp {
    Write-Host 'Debes indicar la ruta del proyecto donde se instalara el kit (carpeta raiz de TU app, no la del ZIP).' -ForegroundColor Red
    Write-Host ''
    Write-Host 'Ejemplo:'
    Write-Host '  powershell -ExecutionPolicy Bypass -File C:\descargas\agenticAI-main\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"'
    Write-Host ''
    Write-Host 'O con ruta relativa:'
    Write-Host '  powershell -ExecutionPolicy Bypass -File .\sdd-lite\setup_sdd_lite.ps1 -ProjectPath "..\mi-proyecto"'
}

if ([string]::IsNullOrWhiteSpace($ProjectPath)) {
    Show-ProjectPathHelp
    exit 1
}
if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) {
    Write-Host "[!] No existe la carpeta: $ProjectPath" -ForegroundColor Red
    Show-ProjectPathHelp
    exit 1
}
$ProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path
Set-Location -LiteralPath $ProjectPath
Write-Host "Proyecto: $ProjectPath" -ForegroundColor DarkGray

Write-Host "Configurando agenticAI $EditionLabel..." -ForegroundColor Cyan
Write-Host ''
Write-Host 'Que entorno principal vas a utilizar?'
Write-Host '(Lite + modelos locales ~8 GB: se recomienda Pi u OpenCode; Cursor/Copilot/Claude OK con cloud o GPU >8 GB)' -ForegroundColor DarkGray
Write-Host '1) Cursor (carpeta .cursor/)'
Write-Host '2) GitHub Copilot (.github/copilot-instructions.md)'
Write-Host '3) Claude Code (CLAUDE.md)'
Write-Host '4) Pi (.agents/ + extension .pi/extensions/sdd-commands.ts)'
Write-Host '5) OpenCode (nativo en .agents/)'
$choice = Read-Host 'Selecciona una opcion (1-5)'

if ($choice -notin @('1','2','3','4','5')) { Write-Host 'Opcion no valida.' -ForegroundColor Red; exit 1 }
$root = if ($choice -eq '1') { '.cursor' } else { '.agents' }

if (Test-Path "$root/sdd-kit.md") {
    Write-Host "[!] Ya hay una instalacion en $ProjectPath\$root\. Para actualizar sin perder tus skills usa /sdd-update en el chat." -ForegroundColor Yellow
    exit 1
}
New-Item -ItemType Directory -Force -Path $root | Out-Null
Copy-Item -Path (Join-Path $src '*') -Destination $root -Recurse -Force
Write-Host "[+] Paquete instalado en $ProjectPath\$root\" -ForegroundColor Green
if ($choice -eq '1') {
    Get-ChildItem -Path "$root/rules" -Filter *.md -File | ForEach-Object { Rename-Item -Path $_.FullName -NewName ($_.BaseName + '.mdc') }
    Write-Host '[+] Reglas convertidas a .mdc (formato de Cursor).' -ForegroundColor Green
}

# Proyecta subagentes nativos aislados (origen: $root/subagents/; sin duplicar el kit fuente)
function Project-NativeAgents {
    param(
        [Parameter(Mandatory = $true)][string]$Dest,
        [switch]$OpenCodeMode
    )
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    $pairs = @(
        @{ Src = '1-planner'; Name = 'sdd-planner' },
        @{ Src = '2-implementer'; Name = 'sdd-implementer' },
        @{ Src = '3-qa-reviewer'; Name = 'sdd-qa-reviewer' }
    )
    foreach ($p in $pairs) {
        $srcFile = Join-Path $root "subagents/$($p.Src).md"
        if (-not (Test-Path -LiteralPath $srcFile)) {
            Write-Host "[!] Falta $srcFile; se omite $($p.Name)." -ForegroundColor Yellow
            continue
        }
        $content = Get-Content -LiteralPath $srcFile -Raw -Encoding UTF8
        if ($OpenCodeMode) {
            $content = [regex]::Replace($content, '(?m)^(description: .+)$', "`$1`nmode: subagent", 1)
        }
        Set-Content -Path (Join-Path $Dest "$($p.Name).md") -Value $content -Encoding UTF8 -NoNewline
        Add-Content -Path (Join-Path $Dest "$($p.Name).md") -Value '' -Encoding UTF8
    }
    Write-Host "[+] Subagentes nativos en $Dest/ (sdd-planner, sdd-implementer, sdd-qa-reviewer)." -ForegroundColor Green
}

$ruleFile = if ($choice -eq '1') { 'global-sdd.mdc' } else { 'global-sdd.md' }
$pointer = "Sigue estrictamente la metodologia SDD de ``$root/``: reglas y Triage en ``$root/rules/$ruleFile``, flujos en ``$root/commands/``, convenciones en ``$root/skills/``."
switch ($choice) {
    '1' {
        Write-Host "[+] Cursor lee $root/ directamente; no se necesita archivo puente." -ForegroundColor Green
        Project-NativeAgents -Dest (Join-Path $root 'agents')
    }
    '2' {
        New-Item -ItemType Directory -Force -Path '.github' | Out-Null
        Set-Content -Path '.github/copilot-instructions.md' -Value ("# Reglas de AgenticAI SDD-Lite`n`n" + $pointer) -Encoding UTF8
        Write-Host '[+] .github/copilot-instructions.md generado.' -ForegroundColor Green
        Write-Host "[+] Copilot: subagentes desde $root/subagents/ (sin carpeta nativa)." -ForegroundColor DarkGray
    }
    '3' {
        Set-Content -Path 'CLAUDE.md' -Value ("# Instrucciones del Repositorio`n`n" + $pointer) -Encoding UTF8
        Write-Host '[+] CLAUDE.md generado.' -ForegroundColor Green
        Project-NativeAgents -Dest '.claude/agents'
    }
    '4' {
        Write-Host "[+] Pi: $root/ instalado. Generando extension de slash commands..." -ForegroundColor Green
        # Solo Pi: registra cada comando de commands/ como slash command (la logica sigue en los .md)
        $names = Get-ChildItem -Path "$root/commands" -Filter *.md -File | ForEach-Object { "'" + $_.BaseName + "'" }
        $list = $names -join ', '
        $tsLines = @(
            'export default function (pi: any) {',
            '  // Comandos del kit SDD (generados desde commands/ al instalar)',
            "  const commands = [$list];",
            '',
            '  commands.forEach((cmd) => {',
            '    pi.registerCommand(cmd, {',
            '      description: `Ejecuta el flujo SDD: ${cmd}`,',
            '      handler: async (args: string, ctx: any) => {',
            '        const extra = args?.trim() ? `\n\nContexto adicional del usuario: ${args.trim()}` : '''';',
            ('        const prompt = `Por favor, lee y ejecuta paso a paso las instrucciones definidas en ' + $root + '/commands/${cmd}.md de este repositorio.${extra}`;'),
            '        if (ctx.isIdle()) {',
            '          pi.sendUserMessage(prompt);',
            '        } else {',
            '          pi.sendUserMessage(prompt, { deliverAs: ''followUp'' });',
            '        }',
            '      }',
            '    });',
            '  });',
            '}'
        )
        New-Item -ItemType Directory -Force -Path '.pi/extensions' | Out-Null
        Set-Content -Path '.pi/extensions/sdd-commands.ts' -Value $tsLines -Encoding UTF8
        Write-Host '[+] Extension de Pi generada en .pi/extensions/sdd-commands.ts' -ForegroundColor Green
        Write-Host "    Comandos registrados: $list" -ForegroundColor DarkGray
        Write-Host "[+] Pi: subagentes desde $root/subagents/ (sin carpeta nativa)." -ForegroundColor DarkGray
    }
    '5' {
        # OpenCode: AGENTS.md + opencode.json instructions + .opencode/commands/*.md (slash commands)
        $instr = "$root/rules/global-sdd.md"
        $cfgPath = 'opencode.json'
        if (Test-Path -LiteralPath $cfgPath) {
            try {
                $cfg = Get-Content -LiteralPath $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json
                $list = @()
                if ($cfg.instructions) { $list = @($cfg.instructions) }
                if ($list -notcontains $instr) { $list += $instr }
                $cfg | Add-Member -NotePropertyName instructions -NotePropertyValue $list -Force
                $cfg | ConvertTo-Json -Depth 20 | Set-Content -Path $cfgPath -Encoding UTF8
            } catch {
                Write-Host "[!] No se pudo fusionar opencode.json existente; anade manualmente instructions: [\"$instr\"]" -ForegroundColor Yellow
            }
        } else {
            $json = @"
{
  "`$schema": "https://opencode.ai/config.json",
  "instructions": ["$instr"]
}
"@
            Set-Content -Path $cfgPath -Value $json -Encoding UTF8
        }
        New-Item -ItemType Directory -Force -Path '.opencode/commands' | Out-Null
        $ocNames = @()
        Get-ChildItem -Path "$root/commands" -Filter *.md -File | ForEach-Object {
            $n = $_.BaseName
            $ocNames += $n
            $lines = @(
                '---',
                "description: Ejecuta el flujo SDD: $n",
                '---',
                '',
                "Lee y ejecuta paso a paso las instrucciones definidas en $root/commands/$n.md de este repositorio.",
                'Incluye cualquier argumento del usuario: $ARGUMENTS'
            )
            Set-Content -Path ".opencode/commands/$n.md" -Value $lines -Encoding UTF8
        }
        Write-Host "[+] OpenCode: $root/ + opencode.json instructions -> $instr" -ForegroundColor Green
        Write-Host "[+] Slash commands en .opencode/commands/: $($ocNames -join ', ')" -ForegroundColor Green
        Project-NativeAgents -Dest '.opencode/agents' -OpenCodeMode
        Write-Host '    Tras /sdd-init: GATE compacto en AGENTS.md si instructions carga global-sdd.' -ForegroundColor DarkGray
    }
}

$ref = "$root/skills/stack-conventions/references"
Write-Host ''
Write-Host '=== Configuracion de Frameworks (Opcional) ===' -ForegroundColor Cyan
Write-Host 'Deseas habilitar convenciones de codigo para algun framework en particular?'
Write-Host '1) Si, configurar framework'
Write-Host '2) No, saltar este paso (se conservan todas las guias)'
$frameChoice = Read-Host 'Elige (1-2)'

if ($frameChoice -eq '1' -and (Test-Path $ref)) {
    Write-Host 'Frameworks disponibles:'
    Write-Host '1. Laravel (opcional: + Filament / NativePHP)'
    Write-Host '2. Django'
    Write-Host '3. FastAPI'
    Write-Host '4. Flutter'
    $fw = Read-Host 'Ingresa el numero de tu framework (1-4)'

    $keep = $null
    switch ($fw) {
        '1' {
            $keep = @('laravel.md')
            if ((Read-Host 'Usas Filament? (s/N)') -in @('s','S')) { $keep += 'filament.md' }
            if ((Read-Host 'Usas NativePHP? (s/N)') -in @('s','S')) { $keep += 'nativephp.md' }
        }
        '2' { $keep = @('django.md') }
        '3' { $keep = @('fastapi.md') }
        '4' { $keep = @('flutter.md') }
        default { Write-Host '[!] Opcion no valida. Se conservan todas las guias.' -ForegroundColor Yellow }
    }

    if ($null -ne $keep) {
        Get-ChildItem -Path $ref -File | Where-Object { $keep -notcontains $_.Name } | Remove-Item -Force
        $kept = if ($keep.Count) { $keep -join ', ' } else { 'ninguna' }
        Write-Host "[+] Convencion conservada: $kept. Resto eliminado para ahorrar tokens." -ForegroundColor Green
    }
} else {
    Write-Host 'Saltando configuracion de frameworks.' -ForegroundColor DarkGray
}

Write-Host ''
Write-Host 'Instalacion completada. Siguiente paso: /sdd-init' -ForegroundColor Cyan
Write-Host "Para actualizar usa /sdd-update en el chat (detecta $root/, protege tus skills y no restaura guias que eliminaste)." -ForegroundColor Yellow
