# A tiempo · Aplicación móvil

Prototipo funcional de **a tiempo**, una aplicación para acompañar el tratamiento de medicamentos en casa. El
teléfono es donde suena la alarma de cada dosis, donde se confirma que ya se dio, donde se le pasa una dosis a
la otra persona que cuida y donde se ve cómo va el día del tratamiento.

Es un prototipo para evaluación de experiencia de usuario: **no tiene servidor ni base de datos**. Todos los
datos viven en la memoria del teléfono, así que al cerrar la aplicación todo vuelve al estado inicial. Funciona
**solo en Android**.

## Alcance de la entrega

La entrega pedía construir seis pantallas que completaran un flujo principal, y las pantallas de registro e
ingreso no contaban dentro de esas seis. Decidimos ir más allá: diseñamos en Figma las veintidós pantallas de
la aplicación móvil y las construimos todas, incluidas las de acceso y los caminos de error (la invitación
vencida, el permiso de datos rechazado, la dosis que nadie ha confirmado, la confirmación hecha sin conexión).

Lo hicimos porque queríamos poder recorrer la experiencia completa, de principio a fin, y no solo un tramo del
camino.

### La pantalla de inicio: _Por dónde empezar_

Una aplicación como esta no se usa en línea recta: la alarma suena a su hora, la dosis delegada llega al
teléfono de otra persona y la invitación llega por un enlace. Para que se pueda probar todo sin esperar a
que pase cada cosa, agregamos una pantalla de inicio que **no hace parte del diseño**: un índice de flujos
llamado **Por dónde empezar**.

Cada opción del índice deja los datos del día en el punto que ese flujo necesita y abre su primera pantalla.
Por eso, cada vez que se entra a un flujo desde el índice, los datos se reinician y el recorrido empieza
limpio.

## Distribución de pantallas

El diseño completo son treinta y nueve pantallas: las veintidós de esta aplicación móvil y diecisiete de la
aplicación web. Se repartieron cruzando las dos plataformas, para que cada integrante quedara con pantallas
del flujo principal en las dos aplicaciones.

| Integrante         | Pantallas de esta aplicación móvil                                                                                                  | Cuántas |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------- | ------- |
| **Juan Gutiérrez** | Acceso: `PM1` `PM2` `PM14` `PM13` `PM5` `PM5b` `PM3` `PM3b` · Alarma, flujo principal `FM4`: `PM6` `PM8` `PM9` `PM9b` `PM12` `PM17` | 14      |
| **Nicolás Munar**  | El día: `PM4` `PM4b` `PM7` `PM10` `PM11` `PM11b` `PM15` `PM16`                                                                      | 8       |

Las otras diecisiete pantallas están en el repositorio de la versión web.

## Enlaces

| Recurso                       | Enlace                                                                                                                                               |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Descarga del APK              | [Descargar el APK](https://uniandes-my.sharepoint.com/:u:/g/personal/jm_gutierrezg1_uniandes_edu_co/IQAN89XQUw2qSbx8TrC3RZUnARar1pOzlbc1OXtRiXWDEA8) |
| Repositorio de la versión web | [github.com/jmg06/atiempo-web-app](https://github.com/jmg06/atiempo-web-app)                                                                         |
| Diseño en Figma               | [A tiempo App · Mockups](https://www.figma.com/design/XqwhO9RKSVZWD79l1027zh/A-tiempo-App---Mockups?node-id=12-2&t=o9YuwcPI4q9tjBhl-1)               |

## Dos formas de probar la aplicación

1. **Instalar el APK** en un teléfono Android o en un emulador. Es la forma más rápida: no hay que compilar
   nada. Ver [Instalar el APK](#instalar-el-apk).
2. **Ejecutar el proyecto desde el código**, en un emulador o en un teléfono conectado al computador. Hay que
   instalar varias herramientas y la primera vez toma un buen rato. Ver
   [Instalación paso a paso](#instalación-paso-a-paso).

## Instalar el APK

El enlace de descarga, en la tabla de [Enlaces](#enlaces), pide iniciar sesión con la **cuenta de Uniandes**.
Lo más sencillo es descargar el APK en el computador, donde esa sesión suele estar abierta, y desde ahí
instalarlo en un emulador o pasarlo al teléfono.

**En un emulador de Android:** arrastrar el archivo `.apk` a la ventana del emulador y esperar a que se
instale. Para crear un emulador, ver el [paso 8](#8-preparar-dónde-se-va-a-ver-la-aplicación) de la
instalación.

**En un teléfono con Android 7.0 o superior:**

1. Poner el archivo `.apk` en el teléfono: pasarlo desde el computador (por cable, correo, etc.) o
   descargarlo desde el enlace, tocando **Descargar**.
2. Abrir el archivo (desde la notificación de descarga o desde la aplicación **Archivos**).
3. Si Android dice que no hay permiso para instalar aplicaciones desconocidas, tocar **Configuración**,
   activar **Permitir de esta fuente** y volver atrás.
4. Tocar **Instalar**.
5. Si aparece un aviso de **Google Play Protect** diciendo que la aplicación no es conocida, tocar **Más
   detalles → Instalar de todos modos**. Sale porque la aplicación no viene de la Play Store.

La aplicación queda instalada con el nombre **A tiempo**.

## Herramientas necesarias

Solo hacen falta para ejecutar el proyecto desde el código.

| Herramienta             | Versión                                                    | Para qué sirve                                                       |
| ----------------------- | ---------------------------------------------------------- | -------------------------------------------------------------------- |
| Flutter SDK             | **3.47.4 o superior** (incluye Dart 3.13.3)                | Compila y ejecuta la aplicación                                      |
| Android Studio          | Cualquier versión reciente                                 | Trae el Android SDK, el emulador y Java                              |
| Android SDK             | Plataforma **Android 16 (API 36)** y Command-line Tools    | Las librerías de Android con las que se compila                      |
| Git                     | Cualquier versión reciente                                 | Flutter lo necesita para funcionar, y sirve para descargar el código |
| Emulador **o** teléfono | Emulador con API 36, o teléfono con Android 7.0 o superior | Donde se ve la aplicación                                            |

Recomendado: **Flutter 3.47.4**, que es la versión con la que se desarrolló el proyecto.

Estas se descargan solas la primera vez que se ejecuta la aplicación, no hay que instalarlas a mano:
Gradle 9.3.1, Android Gradle Plugin 9.1.0, Kotlin 2.4.0 y el Android NDK 28.2.

**Computador recomendado:** 16 GB de memoria RAM y unos **20 GB libres** en disco (Android Studio, el Android
SDK y el emulador ocupan bastante). Con 8 GB de RAM puede funcionar, pero es mejor usar un teléfono en vez del
emulador; ver [Solución de problemas](#solución-de-problemas).

**Se necesita conexión a internet** para la instalación y la primera ejecución, que descarga alrededor de 1 GB
de herramientas. La aplicación en sí no usa internet: la tipografía y los íconos vienen incluidos.

### Editor recomendado

[Visual Studio Code](https://code.visualstudio.com/) con la extensión **Flutter** (de Dart Code), que instala
también la extensión **Dart**. Para instalarla: en VS Code, ícono de **Extensions** en la barra izquierda (o
`Ctrl + Shift + X`), buscar `Flutter` e instalar la que publica **Dart Code**.

El proyecto no le pide al editor que sugiera extensiones, así que hay que instalarla a mano.

El editor sirve para leer el código y, como se explica más abajo, también para instalar Flutter y ejecutar la
aplicación con un clic. Pero todo se puede hacer desde una terminal.

## Instalación paso a paso

Los pasos están escritos para **Windows**. En macOS son los mismos, con las diferencias anotadas en cada paso.

### 1. Instalar Git

Descargar el instalador desde [git-scm.com](https://git-scm.com/downloads) e instalarlo aceptando todas las
opciones por defecto. En macOS, Git se instala solo la primera vez que se ejecuta `git` en la terminal.

### 2. Instalar Android Studio

1. Descargar Android Studio desde [developer.android.com/studio](https://developer.android.com/studio) e
   instalarlo con las opciones por defecto.
2. Abrirlo una vez. El asistente de primera ejecución pregunta el tipo de instalación: elegir **Standard** y
   aceptar las licencias. Descarga el Android SDK, el emulador y Java; tarda varios minutos.
3. En la pantalla de bienvenida: **More Actions → SDK Manager** (o, con un proyecto abierto, **Tools → SDK
   Manager**).
   - En la pestaña **SDK Platforms**, marcar **Android 16 (API 36)** si no está instalado.
   - En la pestaña **SDK Tools**, marcar **Android SDK Command-line Tools (latest)**. **Este paso es
     importante**: sin esta herramienta no se pueden aceptar las licencias en el paso 4.
   - Presionar **Apply** y esperar a que termine.

Android Studio no se usa para abrir el proyecto; solo hace falta por lo que instala.

### 3. Instalar Flutter

**Opción A, desde VS Code (la más sencilla):**

1. Instalar VS Code y la extensión **Flutter**, como se explica en [Editor recomendado](#editor-recomendado).
2. Abrir la paleta de comandos con `Ctrl + Shift + P` (en macOS `Cmd + Shift + P`), escribir `Flutter: New
Project` y presionar Enter.
3. VS Code avisa que no encuentra Flutter: presionar **Download SDK**.
4. Elegir una carpeta **sin espacios ni tildes** en la ruta, por ejemplo `C:\dev`. La descarga tarda unos
   minutos.
5. Cuando termine, VS Code pregunta si agrega Flutter al PATH: presionar **Add SDK to PATH**.
6. Cerrar la ventana que pide crear un proyecto nuevo: no hace falta.

**Opción B, a mano:**

1. Descargar el archivo `.zip` de la última versión estable desde
   [docs.flutter.dev/install/archive](https://docs.flutter.dev/install/archive).
2. Descomprimirlo en `C:\flutter` (no en `C:\Program Files`, que tiene un espacio en el nombre).
3. Agregar `C:\flutter\bin` al PATH: menú Inicio → escribir `variables de entorno` → **Editar las variables
   de entorno de esta cuenta** → seleccionar **Path** → **Editar** → **Nuevo** → escribir `C:\flutter\bin` →
   **Aceptar** en todas las ventanas.

Con cualquiera de las dos opciones, **cerrar y volver a abrir** la terminal (y VS Code) después de instalar.

Para comprobar que quedó bien instalado, abrir una terminal (en Windows: menú Inicio → escribir `PowerShell`
→ Enter) y ejecutar:

```bash
flutter --version
```

Debe mostrar `Flutter 3.47.4` o un número mayor, y en la última línea `Dart 3.13.3` o mayor. Si muestra una
versión menor, ejecutar `flutter upgrade`.

### 4. Aceptar las licencias de Android y revisar la instalación

```bash
flutter doctor --android-licenses
```

Va a mostrar varias licencias y preguntar `Accept? (y/N)`. Escribir `y` y Enter en cada una.

Después ejecutar:

```bash
flutter doctor
```

Lo importante es que estas dos líneas tengan el visto `[√]`:

```
[√] Flutter (Channel stable, 3.47.4, ...)
[√] Android toolchain - develop for Android devices (Android SDK version 36...)
```

Es normal que otras líneas salgan con `[X]` o `[!]`, como **Visual Studio**, **Xcode** o **Chrome**: sirven
para otras plataformas que este proyecto no usa.

### 5. Descargar el proyecto

Con Git:

```bash
git clone https://github.com/jmg06/atiempo-mobile-app.git
```

Sin Git: en GitHub, botón verde **Code** → **Download ZIP** → descomprimir la carpeta.

Es mejor dejar el proyecto en una ruta **sin espacios ni tildes**, por ejemplo `C:\proyectos\atiempo-mobile-app`.

### 6. Abrir la carpeta del proyecto en la terminal

```bash
cd atiempo-mobile-app
```

En VS Code: menú **File → Open Folder**, elegir la carpeta, y luego **Terminal → New Terminal**. La terminal
ya queda abierta dentro de la carpeta correcta.

Para saber que está en la carpeta correcta, el comando `dir` (Windows) o `ls` (macOS) debe mostrar un archivo
llamado `pubspec.yaml`.

### 7. Instalar las librerías

```bash
flutter pub get
```

Tarda unos segundos y termina con `Got dependencies!` o `Changed N dependencies!`.

### 8. Preparar dónde se va a ver la aplicación

Hay dos opciones. Basta con una.

**Opción A, emulador (un teléfono virtual en el computador):**

1. Abrir Android Studio → **More Actions → Virtual Device Manager** (o **Device Manager**).
2. Presionar **+** o **Create Virtual Device**, elegir un teléfono (por ejemplo **Pixel 8**) → **Next**.
3. Elegir la imagen de sistema **API 36** (si tiene un ícono de descarga al lado, descargarla primero) →
   **Next** → **Finish**.
4. Presionar el botón ▶ junto al dispositivo para encenderlo, y esperar a que muestre la pantalla de inicio
   de Android. La primera vez tarda un par de minutos.

**Opción B, un teléfono Android de verdad, por cable USB:**

1. En el teléfono: **Ajustes → Acerca del teléfono** y tocar **siete veces** en **Número de compilación**
   (en Samsung está en **Acerca del teléfono → Información de software**). Aparece el mensaje de que ya se es
   desarrollador.
2. **Ajustes → Opciones de desarrollador** → activar **Depuración por USB**.
3. Conectar el teléfono al computador con un cable que transmita datos (algunos cables solo cargan).
4. En el teléfono aparece la pregunta **¿Permitir la depuración por USB?**: marcar **Permitir siempre desde
   este equipo** y tocar **Permitir**.

Con cualquiera de las dos opciones, comprobar que Flutter lo ve:

```bash
flutter devices
```

Debe aparecer una línea con `android` en ella, por ejemplo `sdk gphone64 x86 64 (mobile) • emulator-5554 •
android-x64` o el nombre del teléfono.

### 9. Ejecutar la aplicación

```bash
flutter run
```

Si Flutter pregunta en cuál dispositivo ejecutarla, escribir el número del que dice `android` y presionar
Enter.

**La primera vez tarda entre 5 y 15 minutos**: descarga Gradle y las herramientas de Android, y se queda un
buen rato en la línea `Running Gradle task 'assembleDebug'...`. Es normal; no hay que cerrar la terminal.
Las siguientes veces tarda menos de un minuto.

Cuando termina, la aplicación se abre sola en el emulador o en el teléfono, y la terminal muestra:

```
Flutter run key commands.
r Hot reload.
R Hot restart.
...
```

La terminal debe quedar abierta mientras se usa la aplicación. Para detenerla: hacer clic sobre la terminal y
presionar `q`. La aplicación queda instalada en el emulador o en el teléfono y se puede seguir abriendo desde
su ícono, sin el computador.

**Desde VS Code:** con el emulador encendido o el teléfono conectado, elegir el dispositivo en la esquina
inferior derecha de la ventana y presionar `F5` (o **Run → Start Debugging**).

## Cómo recorrer el prototipo

La aplicación abre en la pantalla **Por dónde empezar**, el índice de flujos que se explica en
[Alcance de la entrega](#la-pantalla-de-inicio-por-dónde-empezar). Estos son los flujos que ofrece:

| Flujo del índice                        | Primera pantalla | Qué deja preparado                                    |
| --------------------------------------- | ---------------- | ----------------------------------------------------- |
| La alarma y la confirmación de la dosis | `PM8`            | El día como está unos minutos antes de las 3:15 p. m. |
| Entrar y ver el día                     | `PM1`            | La dosis de las 3:15 p. m. ya confirmada              |
| La invitación al hogar                  | `PM5`            | El día como está unos minutos antes de las 3:15 p. m. |
| El pre aviso hablado                    | `PM6`            | El día como está unos minutos antes de las 3:15 p. m. |
| La dosis delegada, en el otro teléfono  | `PM12`           | La dosis de las 3:15 p. m. delegada a Marta           |
| Nadie respondió a la alarma             | `PM17`           | El día como está unos minutos antes de las 3:15 p. m. |
| Se confirmó sin conexión                | `PM9b`           | La dosis de las 3:15 p. m. ya confirmada              |
| La invitación venció                    | `PM5b`           | El día como está unos minutos antes de las 3:15 p. m. |

El primero es el **flujo principal** de la entrega (`FM4`).

> **Sobre el botón de volver.** Algunas pantallas no tienen un botón de volver dentro de la aplicación, por el
> tipo de pantalla que son: las de acceso (bienvenida, ingreso, invitación, consentimiento), la pantalla del
> día y las que imitan un aviso del sistema sobre la pantalla bloqueada (la alarma, el pre aviso, la
> confirmación). En esas pantallas se puede volver con los **botones de navegación de Android** (◁) o con el
> **gesto de volver** (deslizar desde el borde izquierdo o derecho de la pantalla hacia el centro).
>
> La aplicación está construida con rutas, así que ese botón o gesto siempre funciona y siempre lleva a la
> pantalla anterior. Volviendo varias veces se llega al índice **Por dónde empezar**. Si se vuelve desde el
> índice, la aplicación se cierra; basta con abrirla otra vez desde su ícono.

Estas son las veintidós pantallas del diseño y dónde encontrarlas. Los códigos (`PM1`, `PM3b`, …) son los
mismos del archivo de Figma, para poder compararlas con las maquetas.

| Código  | Pantalla                                 | Dónde se ve                                                                                    |
| ------- | ---------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `PM1`   | Bienvenida                               | Flujo **Entrar y ver el día**                                                                  |
| `PM2`   | Entra a tu cuenta                        | En `PM1`, al presionar EMPEZAR o Ya tengo cuenta                                               |
| `PM14`  | La cuenta se crea en el computador       | En `PM2`, al presionar No tengo cuenta todavía                                                 |
| `PM5`   | Te invitaron a un hogar                  | Flujo **La invitación al hogar**                                                               |
| `PM5b`  | La invitación venció                     | Flujo **La invitación venció**                                                                 |
| `PM13`  | Crea tu clave                            | En `PM5`, al presionar ACEPTAR LA INVITACIÓN                                                   |
| `PM3`   | Tus datos de salud                       | En `PM2`, al presionar ENTRAR o la huella; o en `PM13`, al presionar CREAR MI CLAVE Y ENTRAR   |
| `PM3b`  | ¿Salir sin dar el permiso?               | En `PM3`, al presionar No acepto                                                               |
| `PM4`   | Hoy, martes 12                           | En `PM3`, al presionar ACEPTO Y CONTINUO; o en `PM9`, al presionar VER EL DÍA                  |
| `PM4b`  | El día con un bloque delegado            | Ver la nota debajo de la tabla                                                                 |
| `PM7`   | Detalle del bloque pendiente             | En `PM6`, al presionar VER EL BLOQUE                                                           |
| `PM15`  | Detalle del bloque programado            | En `PM4`, al tocar el bloque de las 7:00 p. m. o el de las 11:30 p. m.                         |
| `PM16`  | Detalle del bloque cumplido              | En `PM4`, al tocar un bloque ya cumplido (por ejemplo el de las 7:15 a. m.)                    |
| `PM10`  | Quién puede darla                        | En `PM8`, `PM7`, `PM15` o `PM17`, al presionar DELEGAR ESTA DOSIS                              |
| `PM11`  | Se la pasaste a Marta                    | En `PM10`, al presionar PASARLE LA DOSIS                                                       |
| `PM11b` | Marta ya la dio                          | En `PM12`, al presionar YA LA DI                                                               |
| `PM6`   | Faltan 15 minutos (pre aviso)            | Flujo **El pre aviso hablado**                                                                 |
| `PM8`   | Es la hora (alarma)                      | Flujo **La alarma y la confirmación de la dosis**                                              |
| `PM9`   | Quedó registrada                         | En `PM8`, `PM7` o `PM17`, al presionar YA LA DI; o en `PM11`, al presionar CANCELAR Y DARLA YO |
| `PM9b`  | Quedó marcada en el teléfono             | Flujo **Se confirmó sin conexión**                                                             |
| `PM12`  | Te pasaron una dosis (teléfono de Marta) | Flujo **La dosis delegada, en el otro teléfono**                                               |
| `PM17`  | La dosis sigue pendiente                 | Flujo **Nadie respondió a la alarma**                                                          |

Las pantallas con `b` no son pantallas aparte: son estados o variantes de la misma pantalla.

**Cómo llegar a `PM4b`.** Es la pantalla del día cuando hay un bloque delegado esperando que Marta confirme.
Desde el flujo **El pre aviso hablado**: VER EL BLOQUE (`PM7`) → DELEGAR ESTA DOSIS (`PM10`) → PASARLE LA
DOSIS (`PM11`) → volver dos veces (hasta `PM7`) → VER EL DÍA, arriba a la derecha.

Los formularios vienen con datos de ejemplo ya escritos, tal como en los diseños. La cuenta de prueba es
`carlos.restrepo@correo.com` y su clave ya viene puesta en la pantalla de ingreso. Si se borra el correo o la
clave, la pantalla muestra el error correspondiente.

Algunos botones esperan casi un segundo antes de avanzar, para simular la respuesta de un servidor.

Como el prototipo no guarda nada, al cerrar la aplicación o al entrar a un flujo desde el índice se vuelve al
estado inicial. Eso es intencional.

## Tecnologías

- **Flutter 3.47** y **Dart 3.13**
- **Material 3** para los componentes de interfaz, con los colores y la tipografía del sistema de diseño
- **go_router 18** para la navegación por rutas
- Tipografía **Atkinson Hyperlegible Next**, incluida en la aplicación
- **flutter_lints** para el análisis estático del código

## Generar el APK (opcional)

```bash
flutter build apk --release
```

Genera el archivo en `build/app/outputs/flutter-apk/app-release.apk`. Ese archivo se puede copiar a cualquier
teléfono Android e instalar como se explica en [Instalar el APK](#instalar-el-apk).

## Pruebas automatizadas (opcional)

```bash
flutter test
```

Ejecuta las pruebas unitarias del proyecto. Debe terminar con `All tests passed!`.

## Solución de problemas

**`flutter` "no se reconoce como un comando"**
Flutter no quedó en el PATH, o la terminal se abrió antes de instalarlo. Cerrar la terminal (y VS Code),
abrirla de nuevo y repetir. Si sigue igual, revisar el paso 3 de la instalación y reiniciar el computador.

**`flutter doctor` muestra `[X]` en Visual Studio, Xcode o Chrome**
No es un problema. Esas herramientas son para otras plataformas; este proyecto solo usa Android.

**`flutter doctor` dice "cmdline-tools component is missing" o "Android license status unknown"**
Falta instalar las Command-line Tools. Hacer el punto 3 del [paso 2](#2-instalar-android-studio) y después
volver a ejecutar `flutter doctor --android-licenses`.

**`flutter doctor` dice "Unable to locate Android SDK"**
Android Studio no ha terminado su configuración inicial. Abrirlo una vez y completar el asistente. Si sigue
igual, indicarle a Flutter dónde está el SDK (en Windows suele estar en esta ruta, cambiando `USUARIO` por el
nombre de usuario):

```bash
flutter config --android-sdk C:\Users\USUARIO\AppData\Local\Android\Sdk
```

**`flutter pub get` dice "The current Dart SDK version is ... version solving failed"**
La versión de Flutter es muy antigua. Ejecutar `flutter upgrade` y volver a intentar.

**`flutter run` pregunta por Windows, Chrome o Edge, o dice "No supported devices connected"**
Flutter no encuentra ningún dispositivo Android. Este proyecto **solo funciona en Android**: no se puede
ejecutar en el navegador ni como aplicación de escritorio (si se intenta, sale un error como "not configured
to build on the web" o "No Windows desktop project configured"). Encender el emulador o conectar el teléfono
(paso 8), comprobar con `flutter devices` y volver a ejecutar `flutter run`.

**Se queda mucho tiempo en "Running Gradle task 'assembleDebug'..."**
La primera vez es normal que tarde entre 5 y 15 minutos, porque está descargando Gradle y las herramientas de
Android. Esperar. Si pasa de 30 minutos, revisar la conexión a internet.

**Error de memoria: "Could not reserve enough space for object heap", "OutOfMemoryError" o "Gradle daemon disappeared unexpectedly"**
El proyecto le pide a Gradle hasta 8 GB de memoria, y el computador no los tiene disponibles. Abrir el archivo
`android/gradle.properties`, cambiar en la primera línea `-Xmx8G` por `-Xmx4G`, guardar y volver a ejecutar
`flutter run`. También ayuda cerrar otros programas y usar un teléfono en vez del emulador.

**Error que menciona Java, "JDK", "Unsupported class file major version" o "requires Java 17"**
Flutter está usando una versión de Java distinta de la de Android Studio. Indicarle la de Android Studio (esta
es la ruta por defecto en Windows):

```bash
flutter config --jdk-dir "C:\Program Files\Android\Android Studio\jbr"
```

En macOS la ruta es `/Applications/Android Studio.app/Contents/jbr/Contents/Home`.

**Error que menciona el NDK, "failed to install the following SDK components" o licencias no aceptadas**
Volver a ejecutar `flutter doctor --android-licenses`, aceptar todas, y luego `flutter run`. Esa descarga
necesita internet.

**La descarga de Gradle o de las librerías falla ("Could not resolve", "Connection timed out")**
Casi siempre es la conexión a internet o la red de una empresa o universidad que bloquea las descargas.
Intentar desde otra red o con los datos del celular, y volver a ejecutar `flutter run`.

**El error menciona una ruta con espacios, tildes o la letra ñ**
Gradle a veces falla con esos caracteres. Mover el proyecto a una ruta simple como `C:\proyectos` y, si el
problema es la carpeta de Flutter, instalarlo en `C:\flutter`. Después ejecutar `flutter clean` dentro del
proyecto y volver a ejecutar `flutter run`.

**El emulador no enciende, o habla de "hypervisor", "HAXM" o "virtualization"**
La virtualización del computador está apagada. En Windows: menú Inicio → **Activar o desactivar las
características de Windows** → marcar **Plataforma del hipervisor de Windows** → Aceptar → reiniciar. Si
sigue igual, hay que activar la virtualización (Intel VT-x o AMD-V) en la BIOS del computador. La alternativa
más sencilla es usar un teléfono Android por cable (paso 8, opción B).

**El teléfono no aparece en `flutter devices`**
Revisar que la **Depuración por USB** esté activa y que se haya aceptado la pregunta **¿Permitir la
depuración por USB?** en el teléfono (desconectar y volver a conectar el cable para que aparezca otra vez).
Probar con otro cable, porque algunos solo cargan. En Windows, algunos teléfonos (Samsung, por ejemplo)
necesitan el driver USB del fabricante.

**"INSTALL_FAILED_UPDATE_INCOMPATIBLE" o "La app no está instalada"**
Ya hay en el teléfono una versión de la aplicación instalada de otra forma (por ejemplo, desde el APK).
Desinstalar **A tiempo** del teléfono y volver a intentar.

**Algo raro que no se arregla con lo anterior**
Ejecutar, dentro de la carpeta del proyecto:

```bash
flutter clean
flutter pub get
flutter run
```

**Los datos que cambio desaparecen**
Es el comportamiento esperado: el prototipo no tiene servidor y guarda todo en memoria. Se reinician al
cerrar la aplicación y cada vez que se entra a un flujo desde el índice.

**No encuentro cómo volver a la pantalla anterior**
Usar el botón de volver de Android o el gesto de volver; ver la nota
[Sobre el botón de volver](#cómo-recorrer-el-prototipo).
