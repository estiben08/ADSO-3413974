# 📘 Manual Básico de Comandos de Git

> Una guía rápida y sencilla para empezar a usar Git desde cero.

---

## ⚙️ Configuración inicial

Antes de empezar, dile a Git quién eres:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@ejemplo.com"
```

---

## 📁 Crear o clonar un repositorio

**Iniciar un repositorio nuevo en tu carpeta actual:**
```bash
git init
```

**Clonar un repositorio existente de GitHub:**
```bash
git clone https://github.com/usuario/repositorio.git
```

---

## 📋 Ver el estado del proyecto

```bash
git status
```
Te muestra qué archivos han cambiado, cuáles están listos para guardar y cuáles no están siendo rastreados.

---

## ➕ Agregar cambios

**Agregar un archivo específico:**
```bash
git add archivo.txt
```

**Agregar todos los archivos modificados:**
```bash
git add .
```

---

## 💾 Guardar cambios (commit)

```bash
git commit -m "Descripción breve de lo que hiciste"
```

> 💡 Escribe mensajes claros, por ejemplo: `"Agrega página de inicio"` o `"Corrige error en formulario"`.

---

## 🌿 Ramas (branches)

Las ramas te permiten trabajar en nuevas funciones sin afectar el proyecto principal.

**Ver todas las ramas:**
```bash
git branch
```

**Crear una rama nueva:**
```bash
git branch nombre-de-la-rama
```

**Cambiar a una rama:**
```bash
git checkout nombre-de-la-rama
```

**Crear y cambiar a una rama en un solo paso:**
```bash
git checkout -b nombre-de-la-rama
```

**Fusionar una rama con la rama actual:**
```bash
git merge nombre-de-la-rama
```

---

## 🌐 Conectar con GitHub (remoto)

**Ver los repositorios remotos conectados:**
```bash
git remote -v
```

**Conectar tu proyecto local con GitHub:**
```bash
git remote add origin https://github.com/usuario/repositorio.git
```

---

## 🚀 Subir y bajar cambios

**Subir tus cambios a GitHub:**
```bash
git push origin main
```

**Bajar los cambios más recientes de GitHub:**
```bash
git pull origin main
```

---

## 🕓 Ver el historial de commits

```bash
git log
```

**Versión resumida y más legible:**
```bash
git log --oneline
```

---

## ↩️ Deshacer cambios

**Deshacer cambios en un archivo antes de hacer commit:**
```bash
git checkout -- archivo.txt
```

**Quitar un archivo del área de staging (sin borrar los cambios):**
```bash
git reset archivo.txt
```

**Volver al commit anterior (¡con cuidado!):**
```bash
git reset --hard HEAD~1
```

---

## 🗑️ Eliminar archivos

**Eliminar un archivo del proyecto y del registro de Git:**
```bash
git rm archivo.txt
```

---

## 🔁 Flujo de trabajo típico

```
1. git pull           ← Bajás los últimos cambios
2. (editás tu código)
3. git add .          ← Preparás los cambios
4. git commit -m "..."← Guardás los cambios
5. git push           ← Subís a GitHub
```

---

## 📌 Comandos de referencia rápida

| Comando | ¿Qué hace? |
|---|---|
| `git init` | Inicia un repositorio |
| `git clone <url>` | Clona un repositorio |
| `git status` | Ve el estado actual |
| `git add .` | Agrega todos los cambios |
| `git commit -m ""` | Guarda los cambios |
| `git push` | Sube a GitHub |
| `git pull` | Baja cambios de GitHub |
| `git branch` | Lista las ramas |
| `git checkout -b` | Crea y cambia de rama |
| `git merge` | Fusiona ramas |
| `git log --oneline` | Historial resumido |

---

*¡Eso es todo lo que necesitás para empezar! 🚀*
