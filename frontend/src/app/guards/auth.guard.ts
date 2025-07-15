/* ===========================================================================
 * IMPORTACIONES NECESARIAS PARA EL GUARD DE AUTENTICACIÓN
 * ===========================================================================
 * - Injectable: permite marcar esta clase como servicio inyectable
 * - CanActivate: interfaz que define si una ruta puede activarse
 * - Router: para redirigir al usuario si no está autenticado
 * - AuthService: servicio que expone método para obtener el usuario
 * - Observable, of: para trabajar con flujos reactivos
 * - catchError, map: operadores RxJS para transformar y manejar errores
 * =========================================================================== */
import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

/* ===========================================================================
 * DECORADOR @Injectable
 * ===========================================================================
 * Define este guard como un servicio disponible a nivel de toda la app.
 * ===========================================================================
 */
@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
  /* =========================================================================
   * CONSTRUCTOR
   * =========================================================================
   * Recibe:
   * - authService: para verificar si hay un usuario autenticado
   * - router: para redirigir si no lo hay
   * ========================================================================= */
  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  /* =========================================================================
   * MÉTODO PRINCIPAL: canActivate
   * =========================================================================
   * - Devuelve un Observable<boolean>
   * - Verifica si hay usuario autenticado usando authService.getUser()
   * - Si hay usuario, permite acceder a la ruta (true)
   * - Si NO hay usuario o hay error, redirige a /login y bloquea acceso (false)
   * ========================================================================= */
  canActivate(): Observable<boolean> {
    return this.authService.getUser().pipe(
      map((response) => {
        if (response && response.user) {
          return true; // ✅ Usuario autenticado: acceso permitido
        }
        this.router.navigate(['/login']); // No autenticado: redirigir a login
        return false;
      }),
      catchError(() => {
        this.router.navigate(['/login']); // Error: redirigir a login
        return of(false); // Acceso bloqueado
      })
    );
  }
}
