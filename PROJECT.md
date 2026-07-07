# PROJECT.md

# WoW WotLK Community - Project Guidelines

## Objetivo

Este repositorio tiene como objetivo centralizar todos los recursos oficiales utilizados por la comunidad para World of Warcraft Wrath of the Lich King (3.3.5a).

El proyecto pretende proporcionar una instalación sencilla, organizada y mantenible para cualquier jugador.

El repositorio no almacena únicamente addons, sino todo el ecosistema necesario para jugar con la configuración oficial de la comunidad.

---

# Estructura del proyecto

```
wow-wotlk-community/

addons/
client-patches/
weakauras/
profiles/
macros/
guides/
docs/
launcher/

README.md
CHANGELOG.md
CONTRIBUTING.md
PROJECT.md
manifest.json
VERSION
LICENSE
```

Cada carpeta tiene una finalidad específica y no debe utilizarse para almacenar contenido diferente.

---

# Organización de addons

Cada addon principal tendrá su propia carpeta.

Ejemplo:

```
addons/

DBM/
GTFO/
WeakAuras/
MRT/
Grid2/
```

Dentro de cada carpeta se almacenarán exactamente los archivos y carpetas que deben copiarse dentro de:

```
World of Warcraft/
Interface/
AddOns/
```

No se modificarán los nombres originales de los addons.

---

# Clasificación de addons

Los addons pueden pertenecer a tres categorías.

## Obligatorios

Necesarios para participar en las raids oficiales de la comunidad.

Ejemplos:

- DBM
- GTFO
- MRT
- WeakAuras

## Recomendados

Mejoran la experiencia del jugador pero no son obligatorios.

Ejemplos:

- ElvUI
- Grid2
- HealBot
- Skada
- xCT+

## No incluidos

No forman parte del repositorio oficial.

Ejemplos:

- Questie
- Auctionator
- Carbonite
- GatherMate
- TomTom

---

# Client Patches

La carpeta client-patches contiene modificaciones del cliente que no son addons.

Ejemplos:

- Mejoras visuales
- Rango de bosses
- Modelos
- Texturas
- Sonidos
- Archivos MPQ

Nunca se mezclarán con addons.

---

# WeakAuras

Las WeakAuras se almacenarán separadas de los addons.

Su organización dependerá del contenido.

Ejemplo:

```
weakauras/

ICC/
RS/
Classes/
Utilities/
```

---

# Profiles

Los perfiles de addons nunca se almacenarán dentro del addon correspondiente.

Todos los perfiles estarán centralizados.

Ejemplo:

```
profiles/

ElvUI/
Grid2/
Skada/
Details/
```

---

# Versionado

El repositorio utiliza su propio sistema de versiones.

Ejemplo:

v1.0.0

La versión del repositorio es independiente de la versión de cada addon.

---

# manifest.json

manifest.json será el archivo maestro del proyecto.

Toda herramienta desarrollada para este repositorio deberá utilizar manifest.json como fuente oficial de información.

El launcher nunca analizará las carpetas directamente.

Siempre leerá manifest.json.

---

# Flujo de trabajo

Cada modificación seguirá el mismo proceso.

1. Añadir contenido.
2. Revisar cambios.
3. Actualizar README si es necesario.
4. Actualizar CHANGELOG.
5. Actualizar manifest.json.
6. Commit.
7. Push.

---

# Filosofía del proyecto

La prioridad del proyecto es:

1. Simplicidad
2. Organización
3. Facilidad de instalación
4. Mantenimiento
5. Automatización futura

Nunca se añadirán carpetas o archivos que no tengan una finalidad clara.

Toda modificación deberá mantener la coherencia del proyecto.