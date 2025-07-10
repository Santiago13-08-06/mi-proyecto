import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router'; // ✅ Importa RouterOutlet

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet], // ✅ Usa RouterOutlet, no LoginComponent aquí
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'] // ✅ Usa styleUrls (con "s")
})
export class AppComponent {
  title = 'mi-aplicacion';
}
