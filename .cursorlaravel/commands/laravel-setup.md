# /setup - Inicialización Entorno Laravel & Base de Datos (MariaDB)

Este comando automatiza la configuración inicial del entorno local de Laravel, gestionando el archivo `.env`, configurando MariaDB y ejecutando las migraciones con fallback automático a `migrate:fresh` si ocurre un error.

## Instrucción para la IA

Ejecuta de forma interactiva y paso a paso la inicialización del proyecto:

### PASO 1: Gestión del archivo `.env`
1. Revisa si existe el archivo `.env` en la raíz del proyecto:
   - **Si YA existe**: Notifica al usuario que el archivo `.env` está presente y salta al PASO 3.
   - **Si NO existe**: Verifica si existe `.env.example`. 
     - Haz una copia exacta de `.env.example` y llámala `.env`.

### PASO 2: Configuración Interactiva de MariaDB
Si creaste el archivo `.env` en el paso anterior, solicita activamente al usuario la siguiente información para la base de datos MariaDB:
1. **Nombre de la Base de Datos** (`DB_DATABASE`)
2. **Usuario** (`DB_USERNAME`)
3. **Contraseña** (`DB_PASSWORD`)

Una vez recibidos los datos, actualiza las variables en el `.env`:
```env
DB_CONNECTION=mariadb
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=[Nombre proporcionado]
DB_USERNAME=[Usuario proporcionado]
DB_PASSWORD=[Contraseña proporcionada]
```
*(Nota: Si las variables estaban comentadas en `.env.example`, descoméntalas).*

### PASO 3: Clave de Aplicación (App Key)
1. Revisa si la variable `APP_KEY` en el `.env` está vacía o si falta la clave.
2. Si falta la clave, ejecuta en la terminal del proyecto:
   ```bash
   php artisan key:generate
   ```

### PASO 4: Ejecución de Migraciones con Manejo de Fallos
1. Intenta ejecutar primero la migración estándar con sus seeders:
   ```bash
   php artisan migrate --seed
   ```
2. **Verificación de éxito**:
   - **Si el comando finaliza sin errores**: Informa que la base de datos se migró correctamente.
   - **Si ocurre un error** (por ejemplo, tablas ya existentes, conflictos de claves foráneas o migración trunca):
     - Notifica el fallo detectado al usuario.
     - Reintenta automáticamente limpiando la base de datos desde cero con:
       ```bash
       php artisan migrate:fresh --seed
       ```

---

## Formato de Salida
1. Reporta el estado de cada paso (Copia de `.env`, Configuración de MariaDB, Generación de Key, Migraciones/Seeders y si fue necesario usar `migrate:fresh`).
2. Confirma que el proyecto está listo para ejecutarse con `php artisan serve`.
