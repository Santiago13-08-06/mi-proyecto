import { Component, OnInit } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators, FormGroup } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth.service';

/**
 * Estructura de la respuesta de login esperada desde el backend.
 */
interface LoginResponse {
  token: string;
  user: {
    id: number;
    name: string;
    email: string;
  };
}

/**
 * Componente de inicio de sesión.
 * Incluye formulario reactivo, validaciones y manejo de autenticación.
 */
@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  /**
   * Formulario reactivo de login.
   */
  loginForm!: FormGroup;

  /**
   * Mensaje de error para feedback del usuario.
   */
  errorMsg: string = '';

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router) {}

  /**
   * Inicializa el formulario con validadores.
   */
  ngOnInit(): void {
    this.loginForm = this.fb.nonNullable.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });
  }

  /**
   * Getter para acceder fácilmente al control de email.
   */
  get email() {
    return this.loginForm.get('email')!;
  }

  /**
   * Getter para acceder fácilmente al control de password.
   */
  get password() {
    return this.loginForm.get('password')!;
  }

  /**
   * Envía el formulario de login.
   * Realiza la autenticación y gestiona la respuesta.
   */
  onSubmit(): void {
    this.errorMsg = '';

    if (this.loginForm.valid) {
      const { email, password } = this.loginForm.value;

      this.authService.login(email, password).subscribe({
        next: (res: LoginResponse) => {
          // Guarda token y usuario en localStorage
          localStorage.setItem('token', res.token);
          localStorage.setItem('user', JSON.stringify(res.user));

          // Redirige al dashboard principal
          this.router.navigate(['/dashboard']);
        },
        error: (err: any) => {
          console.error('Error al iniciar sesión', err);
          if (err.status === 401) {
            this.errorMsg = err.error.message || 'Credenciales incorrectas.';
          } else {
            this.errorMsg = 'Error al iniciar sesión. Intenta más tarde.';
          }
        },
      });
    }
  }
}
