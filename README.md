# SISTEMA DE ADMINISTRACION ENCOMAQ (propiedad de IMNegocios)

## Objetivo

Pasar a mejores tecnologias y mas actualizadas el sistema

## Tecnologías

1. Angular v8.3.3+	[angular/cli](https://www.npmjs.com/package/@angular/cli)
2. Laravel v6.0+	[Laravel](https://laravel.com) -> [upgrade laravel to 6.0 from 5.8](https://laravel.com/docs/6.0/upgrade).
3. PHP v7.2+		[PHP](https://www.php.net/)
4. MySQL v5.7+	[MySQL](https://www.mysql.com/)
5. Bootstrap v4.3.1+	[Bootstrap](https://getbootstrap.com/)
6. JQUERY v3.4.1+	[JQUERY](https://jquery.com/)

## Clonación y configuración del entorno de trabajo

1. Clonar el sistema.
2. Cambiar al branch develop (desarrollo).
3. Configurar la conexión a la misma en el archivo `.env` de laravel.
4. Entrar a `app-frontend-angular`; y ejecutar: `npm install`.
5. Editar `app-frontend-angular/src/environments/environment.ts`; en la variable `baseUrl` poner la url de desarrollo, normalmente: `http://localhost:8000`, el cual es el de laravel
6. Los branch de desarrollo se crean desde el ticket (historia de usuario) del JIRA (opcion crear rama desde develop). Al terminar el ticket, se cierra el branch y se realiza un Pull Request para subir el cambio a la rama develop
7. Listo ;), a desarrollar
