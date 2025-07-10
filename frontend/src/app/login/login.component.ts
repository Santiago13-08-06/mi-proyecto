import { Component, OnInit } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators, FormGroup } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth.service';

interface LoginResponse {
  token: string;
  user: {
    id: number;
    name: string;
    email: string;
  };
}

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginForm!: FormGroup;
  errorMsg: string = '';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loginForm = this.fb.nonNullable.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });
  }

  get email() {
    return this.loginForm.get('email')!;
  }

  get password() {
    return this.loginForm.get('password')!;
  }

  onSubmit(): void {
    this.errorMsg = '';

    if (this.loginForm.valid) {
      const { email, password } = this.loginForm.value;

      console.log('Intentando iniciar sesión con:', { email });

      this.authService.login(email, password).subscribe({
        next: (res: LoginResponse) => {
          console.log('Login exitoso', res);

          // ✅ Guardar token y usuario en localStorage
          localStorage.setItem('token', res.token);
          localStorage.setItem('user', JSON.stringify(res.user));

          // ✅ Redirigir al dashboard
          this.router.navigate(['/dashboard']);
        },
        error: (err: any) => {
          console.error('Error al iniciar sesión', err);
          if (err.status === 401) {
            this.errorMsg = err.error.message || 'Credenciales incorrectas.';
          } else {
            this.errorMsg = 'Error al iniciar sesión. Intenta más tarde.';
          }
        }
      });
    }
  }
}
