import { Component, OnInit, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
import { FormBuilder, FormGroup, Validators, AbstractControl, ValidationErrors } from '@angular/forms';
import { TaskService } from '../services/task.service';
import { AuthService } from '../services/auth.service';
import { CategoriasService } from '../services/categorias.service';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { FiltroTareaPipe } from '../pipes/filtro-tarea.pipe';
import { ToastrService } from 'ngx-toastr';
import * as XLSX from 'xlsx';
import * as FileSaver from 'file-saver';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { Router } from '@angular/router';

export function noSoloEspaciosValidator(control: AbstractControl): ValidationErrors | null {
  const value = control.value || '';
  return value.trim().length === 0 ? { soloEspacios: true } : null;
}

export function fechaNoPasadaValidator(control: AbstractControl): ValidationErrors | null {
  const valor = control.value;
  if (!valor) return null;

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  const fechaIngresada = new Date(valor);
  fechaIngresada.setHours(0, 0, 0, 0);

  return fechaIngresada < hoy ? { fechaPasada: true } : null;
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  encapsulation: ViewEncapsulation.None
})
export class DashboardComponent implements OnInit {
  @ViewChild('tituloInput') tituloInput!: ElementRef<HTMLInputElement>;
  taskForm: FormGroup;
  tareas: any[] = [];
  categorias: any[] = [];
  tareaExpandidaId: number | null = null;
  editando: boolean = false;
  modoOscuroActivado: boolean = false;
  tareaEditandoId: number | null = null;
  usuario: any = null;
  filtroBusqueda: string = '';
  nuevaCategoria: string = '';
  errorCategoria: string = '';
  pendientesCount: number = 0;
  completadasCount: number = 0;
  enProgresoCount: number = 0;
  filtroActual: 'todas' | 'pendientes' | 'completadas' | 'en_progreso' = 'todas';

  constructor(
    private fb: FormBuilder,
    private taskService: TaskService,
    private authService: AuthService,
    private categoriasService: CategoriasService,
    private toastr: ToastrService,
    private router: Router
  ) {
    this.taskForm = this.fb.group({
      titulo: ['', [Validators.required, Validators.minLength(1), noSoloEspaciosValidator]],
      descripcion: ['', [Validators.required, Validators.minLength(3), noSoloEspaciosValidator]],
      estado: ['pendiente', Validators.required],
      prioridad: ['', Validators.required],
      fechaLimite: ['', [fechaNoPasadaValidator]],
      idCategoria: [''],
      nuevaCategoria: ['']
    });
  }

  ngOnInit(): void {
    this.filtroActual = 'todas';

    this.authService.getUser().subscribe({
      next: (user) => {
        if (!user) return;
        this.usuario = user;
        this.cargarTareas();
      },
      error: (err) => console.error('No autenticado', err)
    });

    this.categoriasService.obtenerCategorias().subscribe({
      next: (data) => this.categorias = data,
      error: (err) => console.error('Error cargando categorías', err)
    });

    // Escucha los cambios del select de categoría
    this.taskForm.get('idCategoria')?.valueChanges.subscribe((value) => {
      // Limpiar el input de nueva categoría cuando se selecciona una existente
      if (value && value !== '') {
        this.nuevaCategoria = '';
        this.errorCategoria = '';
      }
    });

    const modoGuardado = localStorage.getItem('modoOscuro');
    this.modoOscuroActivado = modoGuardado === 'true';
    this.aplicarModoOscuro();
  }

  cargarTareas(): void {
    this.taskService.getTasks().subscribe({
      next: (res) => {
        this.tareas = res.map((t: any) => ({
          ...t,
          estado: t.estado?.toLowerCase() || 'pendiente'
        }));

        this.pendientesCount = this.tareas.filter(t => t.estado === 'pendiente').length;
        this.completadasCount = this.tareas.filter(t => t.estado === 'completada').length;
        this.enProgresoCount = this.tareas.filter(t => t.estado === 'en_progreso').length;
      },
      error: (err) => console.error('Error al cargar tareas:', err)
    });
  }

  addTask(): void {
    if (this.taskForm.invalid) return;

    const tareaData = {
      ...this.taskForm.value,
      estado: 'pendiente',
      idCategoria: this.taskForm.value.idCategoria || null
    };

    if (this.editando && this.tareaEditandoId !== null) {
      this.taskService.updateTask(this.tareaEditandoId, tareaData).subscribe({
        next: () => {
          this.toastr.info('Tarea actualizada 📝');
          this.resetFormulario();
          this.cargarTareas();
        },
        error: (err) => console.error('Error al actualizar tarea:', err)
      });
    } else {
      this.taskService.createTask(tareaData).subscribe({
        next: () => {
          this.toastr.success('Tarea creada exitosamente ✅');
          this.resetFormulario();
          this.cargarTareas();
        },
        error: (err) => console.error('Error al guardar tarea:', err)
      });
    }
  }

  editarTarea(tarea: any): void {
    this.editando = true;
    this.tareaEditandoId = tarea.idTareas;
    this.taskForm.patchValue({
      titulo: tarea.titulo,
      descripcion: tarea.descripcion,
      estado: tarea.estado?.toLowerCase(),
      prioridad: tarea.prioridad?.toLowerCase(),
      fechaLimite: tarea.fechaLimite,
      idCategoria: tarea.idCategoria || ''
    });

    setTimeout(() => this.tituloInput.nativeElement.focus());
  }

  eliminarTarea(id: number): void {
    if (confirm('¿Seguro que quieres eliminar esta tarea?')) {
      this.taskService.deleteTask(id).subscribe({
        next: () => {
          this.toastr.error('Tarea eliminada 🗑️');
          this.cargarTareas();
        },
        error: (err) => console.error('Error al eliminar tarea:', err)
      });
    }
  }

  cambiarEstado(id: number, nuevoEstado: string) {
    this.taskService.actualizarEstado(id, nuevoEstado).subscribe(() => {
      const tarea = this.tareas.find(t => t.id === id || t.idTareas === id);
      if (tarea) {
        tarea.estado = nuevoEstado;

        this.pendientesCount = this.tareas.filter(t => t.estado === 'pendiente').length;
        this.completadasCount = this.tareas.filter(t => t.estado === 'completada').length;
        this.enProgresoCount = this.tareas.filter(t => t.estado === 'en_progreso').length;
      }

      this.toastr.success('Estado actualizado correctamente ✅');
    }, () => {
      this.toastr.error('No se pudo actualizar el estado ❌');
    });
  }

  toggleExpandir(id: number): void {
    this.tareaExpandidaId = this.tareaExpandidaId === id ? null : id;
  }

  resetFormulario(): void {
    this.taskForm.reset({
      titulo: '',
      descripcion: '',
      estado: 'pendiente',
      prioridad: '',
      fechaLimite: '',
      idCategoria: ''
    });
    this.editando = false;
    this.tareaEditandoId = null;
    this.nuevaCategoria = '';
    this.errorCategoria = '';

    setTimeout(() => this.tituloInput?.nativeElement.focus());
  }

  getPrioridadClass(prioridad: string): string {
    switch (prioridad.toLowerCase()) {
      case 'alta': return 'tag-alta';
      case 'media': return 'tag-media';
      case 'baja': return 'tag-baja';
      default: return '';
    }
  }

  exportarExcel(): void {
    const worksheet = XLSX.utils.json_to_sheet(this.tareas);
    const workbook = { Sheets: { 'Tareas': worksheet }, SheetNames: ['Tareas'] };
    const excelBuffer: any = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
    const blob = new Blob([excelBuffer], { type: 'application/octet-stream' });
    FileSaver.saveAs(blob, 'tareas.xlsx');
  }

  exportarPDF(): void {
    const doc = new jsPDF();
    autoTable(doc, {
      head: [['Título', 'Descripción', 'Estado', 'Prioridad', 'Fecha Límite']],
      body: this.tareas.map(t => [
        t.titulo,
        t.descripcion || '',
        t.estado,
        t.prioridad,
        t.fechaLimite ? new Date(t.fechaLimite).toLocaleDateString() : ''
      ])
    });
    doc.save('tareas.pdf');
  }

  cerrarSesion(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
    this.toastr.info('Sesión cerrada correctamente 👋');
  }

  getTareasFiltradas(): any[] {
    let tareasFiltradas = [...this.tareas];

    if (this.filtroActual === 'pendientes') {
      tareasFiltradas = tareasFiltradas.filter(t => t.estado === 'pendiente');
    } else if (this.filtroActual === 'completadas') {
      tareasFiltradas = tareasFiltradas.filter(t => t.estado === 'completada');
    } else if (this.filtroActual === 'en_progreso') {
      tareasFiltradas = tareasFiltradas.filter(t => t.estado === 'en_progreso');
    }

    if (this.filtroBusqueda.trim() !== '') {
      tareasFiltradas = tareasFiltradas.filter(t =>
        t.titulo.toLowerCase().includes(this.filtroBusqueda.toLowerCase())
      );
    }

    return tareasFiltradas;
  }

  crearCategoria(): void {
    const nombre = this.nuevaCategoria?.trim();
    if (!nombre) {
      this.errorCategoria = 'El nombre no puede estar vacío.';
      return;
    }

    // Verificar si ya existe una categoría con ese nombre
    if (this.categorias.some(cat => cat.nombre.toLowerCase() === nombre.toLowerCase())) {
      this.errorCategoria = 'Ya existe una categoría con ese nombre.';
      return;
    }

    this.categoriasService.crearCategoria({ nombre }).subscribe({
      next: (categoriaCreada) => {
        this.categorias.push(categoriaCreada);
        this.taskForm.get('idCategoria')?.setValue(categoriaCreada.idCategoria);
        this.nuevaCategoria = '';
        this.errorCategoria = '';
        this.toastr.success('Categoría creada correctamente ✅');
      },
      error: (err) => {
        console.error('Error al crear categoría', err);
        this.errorCategoria = 'No se pudo crear la categoría.';
      }
    });
  }

  eliminarCategoriaSeleccionada(): void {
    const id = this.getCategoriaSeleccionadaId();
    if (!id) return;

    const categoria = this.categorias.find(c => c.idCategoria === id);
    if (!categoria) return;

    if (confirm(`¿Estás seguro de que deseas eliminar la categoría "${categoria.nombre}"?`)) {
      this.categoriasService.eliminarCategoria(id).subscribe({
        next: () => {
          this.categorias = this.categorias.filter(c => c.idCategoria !== id);
          this.taskForm.get('idCategoria')?.setValue('');
          this.nuevaCategoria = '';
          this.errorCategoria = '';
          this.toastr.success('Categoría eliminada correctamente ✅');
        },
        error: (err) => {
          console.error('Error al eliminar categoría', err);
          this.toastr.error('No se pudo eliminar la categoría ❌');
        }
      });
    }
  }

  manejarClickCategoria(): void {
    if (this.esCategoriaExistenteSeleccionada()) {
      this.eliminarCategoriaSeleccionada();
    } else {
      this.crearCategoria();
    }
  }

  getCategoriaSeleccionadaId(): number | null {
    const value = this.taskForm.get('idCategoria')?.value;
    return value && value !== '' ? Number(value) : null;
  }

  esCategoriaExistenteSeleccionada(): boolean {
    const idSel = this.getCategoriaSeleccionadaId();
    return (
      idSel !== null &&
      this.categorias.some(c => c.idCategoria === idSel)
    );
  }

  getNombreCategoriaSeleccionada(): string {
    const id = this.getCategoriaSeleccionadaId();
    if (!id) return '';
    const categoria = this.categorias.find(c => c.idCategoria === id);
    return categoria ? categoria.nombre : '';
  }

  // Métodos para mostrar/ocultar el input de nueva categoría
  mostrarInputNuevaCategoria(): boolean {
    return !this.esCategoriaExistenteSeleccionada();
  }

  verTodas() {
    this.filtroActual = 'todas';
  }

  alternarPendientes() {
    this.filtroActual = this.filtroActual === 'pendientes' ? 'todas' : 'pendientes';
  }

  alternarCompletadas() {
    this.filtroActual = this.filtroActual === 'completadas' ? 'todas' : 'completadas';
  }

  alternaEnProgreso() {
    this.filtroActual = this.filtroActual === 'en_progreso' ? 'todas' : 'en_progreso';
  }

toggleModoOscuro(): void {
  this.modoOscuroActivado = !this.modoOscuroActivado;
  this.aplicarModoOscuro();
  localStorage.setItem('modoOscuro', String(this.modoOscuroActivado));
}

aplicarModoOscuro(): void {
  if (this.modoOscuroActivado) {
    document.body.classList.add('dark-mode');
  } else {
    document.body.classList.remove('dark-mode');
  }
}
}



