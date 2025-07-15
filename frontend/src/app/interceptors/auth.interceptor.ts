import { HttpInterceptorFn } from '@angular/common/http';

/**
 * authInterceptor
 * ---------------
 * Interceptor HTTP que:
 * - Obtiene el token JWT almacenado en localStorage.
 * - Si existe, clona la petición y añade el header Authorization.
 * - Siempre envía las credenciales (cookies) si aplica.
 */
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  // Intenta recuperar el token JWT del almacenamiento local
  const token = localStorage.getItem('token');

  // Clona la petición original y añade encabezados si hay token
  const authReq = token
    ? req.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`,
        },
        withCredentials: true, // Incluye cookies si se usan
      })
    : req.clone({
        withCredentials: true,
      });

  // Continúa con la cadena de interceptores
  return next(authReq);
};
