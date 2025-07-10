import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { tap, catchError } from 'rxjs/operators';

interface MeResponse {
  user: {
    id: number;
    name: string;
    email: string;
    // ... cualquier otro campo que devuelva Laravel
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
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost:8000/api';
  private user: any = null;

  constructor(private http: HttpClient) {}

  // ✅ Iniciar sesión
  login(email: string, password: string): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(`${this.apiUrl}/login`, {
      email,
      password
    }, { withCredentials: true });
  }

  // ✅ Obtener usuario autenticado
  getUser(): Observable<MeResponse | null> {
  const token = localStorage.getItem('token');
  const headers = { Authorization: `Bearer ${token}` };

  return this.http.get<MeResponse>(`${this.apiUrl}/me`, { headers }).pipe(
    tap(response => this.user = response.user),
    catchError(() => of(null))
  );
}




  get usuarioActual() {
    return this.user;
  }

  // ✅ Registrar nuevo usuario
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
    password_confirmation: passwordConfirmation
  };

  return this.http.post(`${this.apiUrl}/register`, data, {
    withCredentials: true
  });
}

logout(): void {
  localStorage.removeItem('token'); // o lo que estés usando
  // También puedes limpiar usuario, etc.
}

}
