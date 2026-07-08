# PROJECT

## Objetivo

Este repositorio tiene como objetivo centralizar todos los recursos oficiales utilizados por la comunidad para **World of Warcraft Wrath of the Lich King 3.3.5a (Warmane)**, orientado exclusivamente a **PvE**.

El proyecto proporciona una colección organizada y mantenible de addons, perfiles, WeakAuras, parches visuales, macros, guías y herramientas oficiales de la comunidad, facilitando tanto la instalación como el mantenimiento y el desarrollo futuro.

---

# Principios del proyecto

- Cada carpeta debe tener una única responsabilidad.
- Cada documento debe tener una única responsabilidad.
- Los addons originales nunca se modifican.
- Las configuraciones personalizadas siempre se almacenan fuera de los addons originales.
- La organización del repositorio debe priorizar la simplicidad, la mantenibilidad y la escalabilidad.
- Todas las decisiones deben facilitar el desarrollo del futuro launcher.
- Se evitará crear documentación, carpetas o archivos innecesarios.

---

# Arquitectura del proyecto

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
PROJECT.md
ROADMAP.md
CHANGELOG.md
CONTRIBUTING.md
manifest.json
VERSION
LICENSE
```

Cada carpeta y cada documento tienen una única responsabilidad y no deben utilizarse para almacenar información ajena a su finalidad.

---

# Arquitectura documental

| Documento | Responsabilidad |
|-----------|-----------------|
| README.md | Presentación general del repositorio. |
| PROJECT.md | Arquitectura, normas y decisiones permanentes del proyecto. |
| ROADMAP.md | Estado del proyecto, planificación y seguimiento del desarrollo. |
| CHANGELOG.md | Historial de cambios entre versiones. |
| CONTRIBUTING.md | Normas para colaborar en el proyecto. |
| manifest.json | Fuente oficial de información para herramientas y launcher. |

---

# Organización del contenido

## addons/

Contiene todos los addons oficiales del proyecto.

Cada addon dispone de su propia carpeta y de su correspondiente documentación.

Los addons originales nunca se modifican.

---

## client-patches/

Contiene modificaciones del cliente que no son addons.

Ejemplos:

- Archivos MPQ.
- Mejoras visuales.
- Modelos.
- Texturas.
- Sonidos.

Nunca se mezclarán con addons.

---

## weakauras/

Contiene todas las WeakAuras oficiales del proyecto.

Las WeakAuras permanecen completamente separadas de los addons y su organización dependerá de su finalidad.

---

## profiles/

Contiene todos los perfiles oficiales de configuración.

Los perfiles nunca se almacenan dentro de las carpetas de los addons correspondientes.

---

## macros/

Contiene las macros oficiales utilizadas por la comunidad.

---

## guides/

Contiene las guías oficiales del proyecto.

---

## docs/

Contiene documentación técnica complementaria cuando sea necesaria.

---

## launcher/

Reservado para el desarrollo del launcher oficial del proyecto.

---

# Clasificación de addons

Los addons oficiales podrán clasificarse como:

- Obligatorios
- Recomendados

Los addons que no formen parte de la colección oficial no se incluirán en este repositorio.

---

# Sistema de versiones

El repositorio utiliza un sistema de versionado propio.

La versión del repositorio es independiente de la versión individual de cada addon.

---

# manifest.json

`manifest.json` constituye la fuente oficial de información del proyecto.

Cualquier herramienta desarrollada para este repositorio deberá utilizar este archivo como origen de los datos.

El launcher dependerá exclusivamente de `manifest.json` y nunca analizará directamente la estructura física del repositorio.

---

# Filosofía del proyecto

Las prioridades del proyecto son:

1. Simplicidad.
2. Organización.
3. Facilidad de instalación.
4. Mantenibilidad.
5. Escalabilidad.
6. Automatización.

Toda modificación deberá mantener la coherencia de la arquitectura y facilitar la evolución futura del proyecto.