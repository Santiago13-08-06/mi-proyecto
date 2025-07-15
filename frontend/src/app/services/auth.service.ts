import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { tap, catchError } from 'rxjs/operators';

interface MeResponse {
  user: {
    id: number;
    name: string;
    email: string;
  };
}

interface LoginResponse {
  token: string;
  user: {
    id: number;
    name: string;
    email: string;
  };
}

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:8000/api';
  private user: MeResponse['user'] | null = null;

  constructor(private http: HttpClient) {}

  /**
   * Inicia sesión con email y contraseña.
   * @param email Email del usuario
   * @param password Contraseña
   */
  login(email: string, password: string): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(
      `${this.apiUrl}/login`,
      { email, password },
      { withCredentials: true }
    );
  }

  /**
   * Obtiene el usuario autenticado (usando token).
   * Guarda el usuario en la propiedad local para reutilizar.
   */
  getUser(): Observable<MeResponse | null> {
    const token = localStorage.getItem('token');
    if (!token) return of(null);

    const headers = { Authorization: `Bearer ${token}` };

    return this.http.get<MeResponse>(`${this.apiUrl}/me`, { headers }).pipe(
      tap((response) => (this.user = response.user)),
      catchError(() => of(null))
    );
  }

  /**
   * Getter para acceder al usuario autenticado en memoria.
   */
  get usuarioActual() {
    return this.user;
  }

  /**
   * Registra un nuevo usuario.
   * @param nombre Nombre completo
   * @param email Email
   * @param password Contraseña
   * @param passwordConfirmation Confirmación de contraseña
   */
  register(
    nombre: string,
    email: string,
    password: string,
    passwordConfirmation: string
  ): Observable<any> {
    const data = {
      nombreCompleto: nombre,
      email,
      password,
      password_confirmation: passwordConfirmation,
    };

    return this.http.post(`${this.apiUrl}/register`, data, {
      withCredentials: true,
    });
  }

  /**
   * Cierra sesión del usuario.
   * Limpia token y datos locales.
   */
  logout(): void {
    localStorage.removeItem('token');
    this.user = null;
  }
}
