import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent implements OnInit {
  registerForm!: FormGroup;

  serverErrors: { [key: string]: string[] } = {};
  successMessage: string = '';
  errorMsg: string = '';

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router) {}

  ngOnInit(): void {
    this.registerForm = this.fb.group(
      {
        nombreCompleto: ['', [Validators.required, Validators.minLength(3)]],
        email: ['', [Validators.required, Validators.email]],
        password: ['', [Validators.required, Validators.minLength(6)]],
        passwordConfirmation: ['', [Validators.required]],
      },
      { validators: this.passwordMatchValidator }
    );
  }

  /**
   * Validador de coincidencia de contraseñas
   */
  private passwordMatchValidator(form: FormGroup) {
    const password = form.get('password')?.value;
    const confirmPassword = form.get('passwordConfirmation')?.value;
    return password === confirmPassword ? null : { mismatch: true };
  }

  /**
   * Envía el formulario de registro
   */
  onSubmit(): void {
    if (this.registerForm.invalid) return;

    this.serverErrors = {};
    this.successMessage = '';
    this.errorMsg = '';

    const { nombreCompleto, email, password, passwordConfirmation } = this.registerForm.value;

    this.authService.register(nombreCompleto, email, password, passwordConfirmation).subscribe({
      next: (response: any) => {
        this.successMessage = response.message || 'Usuario registrado correctamente.';
        this.registerForm.reset();

        // Redirige al login tras unos segundos
        setTimeout(() => this.router.navigate(['/login']), 1500);
      },
      error: (error: any) => {
        if (error.status === 422 && error.error.errors) {
          this.serverErrors = error.error.errors;
        } else {
          this.errorMsg = 'Ocurrió un error al registrar. Inténtalo de nuevo.';
        }
      },
    });
  }

  /**
   * Getters de campos individuales
   */
  get nombreCompleto() {
    return this.registerForm.get('nombreCompleto');
  }

  get email() {
    return this.registerForm.get('email');
  }

  get password() {
    return this.registerForm.get('password');
  }

  get passwordConfirmation() {
    return this.registerForm.get('passwordConfirmation');
  }

  /**
   * Navega al login
   */
  goToLogin(): void {
    this.router.navigate(['/login']);
  }
}
