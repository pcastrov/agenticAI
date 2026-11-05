# setup_sdd_lite.ps1 - Instalador de agenticAI SDD-Lite (Windows PowerShell)
# Uso:
#   powershell -ExecutionPolicy Bypass -File ruta\a\sdd-full\setup_sdd_lite.ps1 -ProjectPath "C:\ruta\a\tu-proyecto"
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
    Write-Host '  powershell -ExecutionPolicy Bypass -File C:\descargas\agenticAI-main\sdd-full\setup_sdd_lite.ps1 -ProjectPath "C:\Users\tu\mi-proyecto"'
    Write-Host ''
    Write-Host 'O con ruta relativa:'
    Write-Host '  powershell -ExecutionPolicy Bypass -File .\sdd-full\setup_sdd_lite.ps1 -ProjectPath "..\mi-proyecto"'
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
Write-Host '1) Cursor (carpeta .cursor/)'
Write-Host '2) GitHub Copilot (.github/copilot-instructions.md)'
Write-Host '3) Claude Code (CLAUDE.md)'
Write-Host '4) Pi / OpenCode / Cline (nativo en .agents/)'
$choice = Read-Host 'Selecciona una opcion (1-4)'

if ($choice -notin @('1','2','3','4')) { Write-Host 'Opcion no valida.' -ForegroundColor Red; exit 1 }
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

$ruleFile = if ($choice -eq '1') { 'global-sdd.mdc' } else { 'global-sdd.md' }
$pointer = "Sigue estrictamente la metodologia SDD de ``$root/``: reglas y Triage en ``$root/rules/$ruleFile``, flujos en ``$root/commands/``, convenciones en ``$root/skills/``."
switch ($choice) {
    '1' { Write-Host "[+] Cursor lee $root/ directamente; no se necesita archivo puente." -ForegroundColor Green }
    '2' {
        New-Item -ItemType Directory -Force -Path '.github' | Out-Null
        Set-Content -Path '.github/copilot-instructions.md' -Value ("# Reglas de AgenticAI SDD-Lite`n`n" + $pointer) -Encoding UTF8
        Write-Host '[+] .github/copilot-instructions.md generado.' -ForegroundColor Green
    }
    '3' {
        Set-Content -Path 'CLAUDE.md' -Value ("# Instrucciones del Repositorio`n`n" + $pointer) -Encoding UTF8
        Write-Host '[+] CLAUDE.md generado.' -ForegroundColor Green
    }
    '4' {
        Write-Host "[+] $root/ es soportada nativamente por tu herramienta." -ForegroundColor Green
        # Extension de Pi: registra cada comando de commands/ como slash command (la logica sigue en los .md)
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
Write-Host 'Instalacion completada. Siguiente paso: /init' -ForegroundColor Cyan
Write-Host "Para actualizar usa /sdd-update en el chat (detecta $root/, protege tus skills y no restaura guias que eliminaste)." -ForegroundColor Yellow
