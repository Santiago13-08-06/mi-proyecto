/* ===========================================================================
 * IMPORTACIONES
 * =========================================================================== */
import { TestBed } from '@angular/core/testing';
import { Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { AuthGuard } from './auth.guard';
import { of, throwError } from 'rxjs';

/* ===========================================================================
 * BLOQUE DE DESCRIPCIÓN GENERAL DEL TEST SUITE
 * =========================================================================== */
describe('AuthGuard', () => {
  let guard: AuthGuard;
  let authServiceSpy: jasmine.SpyObj<AuthService>;
  let routerSpy: jasmine.SpyObj<Router>;

  /* =========================================================================
   * CONFIGURACIÓN INICIAL ANTES DE CADA TEST
   * ========================================================================= */
  beforeEach(() => {
    // Se crean *spies* (mocks) para AuthService y Router
    authServiceSpy = jasmine.createSpyObj('AuthService', ['getUser']);
    routerSpy = jasmine.createSpyObj('Router', ['navigate']);

    // Configura el TestBed con los mocks
    TestBed.configureTestingModule({
      providers: [
        { provide: AuthService, useValue: authServiceSpy },
        { provide: Router, useValue: routerSpy },
      ],
    });

    // Se inyecta el guardia real usando el TestBed
    guard = TestBed.inject(AuthGuard);
  });

  /* =========================================================================
   * TEST #1: Usuario autenticado debe permitir acceso
   * ========================================================================= */
  it('debe permitir acceso si el usuario está autenticado', (done) => {
    // Simula respuesta exitosa del usuario autenticado
    authServiceSpy.getUser.and.returnValue(
      of({
        user: {
          id: 1,
          name: 'Usuario',
          email: 'usuario@correo.com',
        },
      })
    );

    // Ejecuta canActivate y valida que permita acceso
    guard.canActivate().subscribe((canActivate) => {
      expect(canActivate).toBeTrue();
      done();
    });
  });

  /* =========================================================================
   * TEST #2: Usuario NO autenticado debe redirigir a /login
   * ========================================================================= */
  it('debe redirigir a login si no hay usuario', (done) => {
    // Simula que no existe usuario
    authServiceSpy.getUser.and.returnValue(of(null));

    // Ejecuta canActivate y valida que deniegue y redirija
    guard.canActivate().subscribe((canActivate) => {
      expect(canActivate).toBeFalse();
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/login']);
      done();
    });
  });

  /* =========================================================================
   * TEST #3: Si hay error al validar usuario, debe redirigir
   * ========================================================================= */
  it('debe redirigir a login si ocurre un error', (done) => {
    // Simula un error en la petición del usuario
    authServiceSpy.getUser.and.returnValue(throwError(() => new Error('Error')));

    // Ejecuta canActivate y valida que redirija igual
    guard.canActivate().subscribe((canActivate) => {
      expect(canActivate).toBeFalse();
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/login']);
      done();
    });
  });
});
