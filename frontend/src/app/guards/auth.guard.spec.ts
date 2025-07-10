import { TestBed } from '@angular/core/testing';
import { Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { AuthGuard } from './auth.guard';
import { of, throwError } from 'rxjs';

describe('AuthGuard', () => {
  let guard: AuthGuard;
  let authServiceSpy: jasmine.SpyObj<AuthService>;
  let routerSpy: jasmine.SpyObj<Router>;

  beforeEach(() => {
    authServiceSpy = jasmine.createSpyObj('AuthService', ['getUser']);
    routerSpy = jasmine.createSpyObj('Router', ['navigate']);

    TestBed.configureTestingModule({
      providers: [
        { provide: AuthService, useValue: authServiceSpy },
        { provide: Router, useValue: routerSpy }
      ]
    });

    guard = TestBed.inject(AuthGuard);
  });

  it('debe permitir acceso si el usuario está autenticado', (done) => {
    authServiceSpy.getUser.and.returnValue(of({
      user: {
        id: 1,
        name: 'Usuario',
        email: 'usuario@correo.com'
      }
    }));

    guard.canActivate().subscribe(canActivate => {
      expect(canActivate).toBeTrue();
      done();
    });
  });

  it('debe redirigir a login si no hay usuario', (done) => {
    authServiceSpy.getUser.and.returnValue(of(null));

    guard.canActivate().subscribe(canActivate => {
      expect(canActivate).toBeFalse();
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/login']);
      done();
    });
  });

  it('debe redirigir a login si ocurre un error', (done) => {
    authServiceSpy.getUser.and.returnValue(throwError(() => new Error('Error')));

    guard.canActivate().subscribe(canActivate => {
      expect(canActivate).toBeFalse();
      expect(routerSpy.navigate).toHaveBeenCalledWith(['/login']);
      done();
    });
  });
});
