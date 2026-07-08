# PROJECT - Wowtiktok WotLK Community

Documento maestro del proyecto.

Define la arquitectura, las normas y la filosofía de **Wowtiktok WotLK Community**.

---

# 1. Objetivos del proyecto

## Objetivo principal

Desarrollar y mantener un ecosistema de recursos para **World of Warcraft: Wrath of the Lich King 3.3.5a (Warmane)**, orientado exclusivamente al contenido **PvE**.

## Objetivos específicos

- Centralizar recursos verificados.
- Facilitar la instalación y el mantenimiento.
- Compartir conocimiento con la comunidad.
- Mantener una arquitectura clara y escalable.
- Preparar el proyecto para futuras herramientas.

---

# 2. Filosofía del proyecto

**Wowtiktok WotLK Community** es una comunidad dedicada a ayudar a jugadores nuevos y experimentados a mejorar su rendimiento en **World of Warcraft: Wrath of the Lich King 3.3.5a (Warmane)**.

El repositorio de GitHub, el servidor de Discord y las futuras herramientas forman parte del mismo ecosistema.

## Principios

| Principio | Descripción |
|-----------|-------------|
| Calidad | Priorizar recursos útiles y verificados. |
| Simplicidad | Mantener una estructura clara y fácil de usar. |
| Escalabilidad | Preparar el proyecto para crecer sin reorganizarlo. |
| Mantenibilidad | Facilitar las actualizaciones futuras. |
| Transparencia | Respetar y citar las fuentes originales cuando corresponda. |

---

# 3. Arquitectura del proyecto

- Cada carpeta tiene una única responsabilidad.
- Cada documento tiene una única responsabilidad.
- Los addons originales nunca se modifican.
- Los perfiles y las WeakAuras se distribuyen por separado.
- Toda la arquitectura deberá ser compatible con futuras herramientas del proyecto.

---

# 4. Jerarquía documental

| Documento | Responsabilidad |
|-----------|-----------------|
| `README.md` | Presentación del proyecto. |
| `PROJECT.md` | Arquitectura, normas y filosofía. |
| `ROADMAP.md` | Planificación y seguimiento. |
| `CHANGELOG.md` | Historial oficial de versiones. |
| `CONTRIBUTING.md` | Normas para colaboradores. |
| `manifest.json` | Fuente oficial de datos del proyecto. |
| `addons/README.md` | Organización de la colección de addons. |
| `addons/*/README.md` | Documentación de cada addon. |

**Regla principal**

> La información nunca deberá duplicarse entre documentos.

---

# 5. Estructura del repositorio

```text
addons/
profiles/
weakauras/
guides/
client-patches/

README.md
PROJECT.md
ROADMAP.md
CHANGELOG.md
CONTRIBUTING.md
manifest.json
```

---

# 6. Normas generales

- Compatibilidad exclusiva con **Warmane WotLK 3.3.5a**.
- Contenido orientado exclusivamente al **PvE**.
- No modificar addons originales.
- Todo recurso deberá estar verificado.
- Todo recurso deberá indicar las versiones con las que ha sido verificado.
- No duplicar información.
- Mantener una estructura simple y escalable.

---

# 7. Flujo de trabajo

- Trabajar sobre un único objetivo.
- Esperar aprobación antes de continuar.
- Entregar siempre la versión definitiva tras la aprobación final.
- Agrupar subtareas antes de actualizar el `ROADMAP.md`.
- Actualizar la documentación antes del `git commit` y `git push`.

---

# 8. Estándares de documentación

Toda la documentación deberá cumplir los siguientes principios:

- Máximo valor por línea.
- Una idea por sección.
- Lenguaje claro y consistente.
- Sin información redundante.
- Uso de plantillas siempre que sea posible.

Las guías deberán incluir un apartado **Fuentes verificadas**.

---

# 9. Convenciones técnicas

- Inglés para nombres de carpetas y archivos.
- Español para toda la documentación.
- `client-patches` será el nombre oficial de la carpeta.
- En la documentación se utilizará el término **Parches visuales** cuando corresponda.
- `manifest.json` será la fuente oficial para futuras herramientas.

---

# 10. Integraciones futuras

El proyecto podrá incorporar nuevas herramientas, como:

- Launcher.
- API.
- Automatizaciones.
- Scripts.
- Nuevos servicios para la comunidad.

---

# 11. Registro de decisiones de arquitectura

Este apartado recogerá únicamente las decisiones que modifiquen la arquitectura del proyecto.

---

# Principio de calidad

> **La documentación debe ser tan breve como sea posible, pero tan completa como sea necesario.**

---

# Regla de oro

> **Documentar lo necesario. Explicar lo importante. Eliminar lo innecesario.**