# 📌 Gestor de Tareas con Autenticación (Angular + Laravel)

Este proyecto es una aplicación web **full-stack** para la gestión de tareas personales. Permite a los usuarios **registrarse, iniciar sesión**, crear, actualizar, filtrar y eliminar tareas, además de gestionar categorías para organizarlas de forma flexible.

---

## 🚀 Tecnologías utilizadas

- **Frontend:** [Angular v19] (Standalone components, Reactive Forms, HttpClient, Pipes, Guards)
- **Backend:** [Laravel v12]
- **Base de datos:** PostgreSQL
- **Autenticación:** JWT Token + Cookies (vía Interceptor)
- **Estilos:** CSS modular y responsivo
- **Pruebas:** Jasmine + TestBed para Guards y Servicios

---

## ⚙️ Funcionalidades principales

✅ Registro y autenticación de usuarios con validación de campos  
✅ Inicio de sesión con persistencia de sesión mediante token JWT  
✅ Guard para proteger rutas restringidas (solo usuarios autenticados)  
✅ CRUD de tareas con propiedades: título, descripción, estado, prioridad y fecha límite  
✅ Filtrado de tareas por título mediante Pipe personalizado  
✅ Gestión de categorías: crear y eliminar  
✅ Formularios reactivos con validaciones en frontend y manejo de errores del backend  
✅ Interceptor HTTP para incluir token en cada petición y gestionar credenciales  
✅ Animaciones y estilo responsivo para formularios de login y registro

---

## 📁 Estructura general del proyecto

src/
 ├── app/
 │   ├── services/
 │   │   ├── auth.service.ts
 │   │   ├── categorias.service.ts
 │   │   └── task.service.ts
 │   ├── guards/
 │   │   └── auth.guard.ts
 │   ├── pipes/
 │   │   └── filtro-tarea.pipe.ts
 │   ├── components/
 │   │   ├── login/
 │   │   │   ├── login.component.ts/html/css
 │   │   ├── register/
 │   │   │   ├── register.component.ts/html/css
 │   │   ├── dashboard/ (no incluido en los ejemplos pero sugerido)
 │   ├── interceptors/
 │   │   └── auth.interceptor.ts
 ├── assets/
 │   └── img/
 │       └── logo-login.jpg

---

⚙️ Instalación y ejecución

1. Clonar el repositorio

git clone https://github.com/Santiago13-08-06/mi-proyecto.git
cd tu-repo

2. Instalar dependencias

npm install

3. Ejecutar el backend (Laravel)

Asegurate de tener corriendo el backend:

php artisan serve

4. Iniciar (Angular)

ng serve

---

📌 Notas adicionales

. Este frontend está diseñado para trabajar con un API REST Laravel configurado con Sanctum/JWT.

. Recuerda configurar correctamente tu base de datos y ejecutar las migraciones en el backend.

---

👨‍💻 Autor

Desarrollado por Santiago Tovar — Ingeniero de Software en formación, entusiasta de soluciones prácticas y arquitectura limpia.



