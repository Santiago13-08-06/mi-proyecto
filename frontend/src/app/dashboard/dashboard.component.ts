/* ===========================================================================
 * IMPORTACIONES
 * =========================================================================== */
import { Component, OnInit, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  AbstractControl,
  ValidationErrors,
} from '@angular/forms';
import { TaskService } from '../services/task.service';
import { AuthService } from '../services/auth.service';
import { CategoriasService } from '../services/categorias.service';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import * as XLSX from 'xlsx';
import * as FileSaver from 'file-saver';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { Router } from '@angular/router';

/* ===========================================================================
 * VALIDADORES PERSONALIZADOS
 * =========================================================================== */

/** Valida que un campo no contenga solo espacios en blanco */
export function noSoloEspaciosValidator(control: AbstractControl): ValidationErrors | null {
  const value = control.value || '';
  return value.trim().length === 0 ? { soloEspacios: true } : null;
}

/** Valida que una fecha no sea anterior a la actual */
export function fechaNoPasadaValidator(control: AbstractControl): ValidationErrors | null {
  const valor = control.value;
  if (!valor) return null;

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  const fechaIngresada = new Date(valor);
  fechaIngresada.setHours(0, 0, 0, 0);

  return fechaIngresada < hoy ? { fechaPasada: true } : null;
}

/* ===========================================================================
 * COMPONENTE DASHBOARD
 * =========================================================================== */
@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  encapsulation: ViewEncapsulation.None,
})
export class DashboardComponent implements OnInit {
  /* =========================================================================
   * PROPIEDADES PRINCIPALES DEL COMPONENTE
   * ========================================================================= */

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

  /* =========================================================================
   * CONSTRUCTOR E INYECCIÓN DE DEPENDENCIAS
   * ========================================================================= */
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
      nuevaCategoria: [''],
    });
  }

  /* =========================================================================
   * CICLO DE VIDA: ngOnInit
   * ========================================================================= */
  ngOnInit(): void {
    this.filtroActual = 'todas';

    this.authService.getUser().subscribe({
      next: (user) => {
        if (!user) return;
        this.usuario = user;
        this.cargarTareas();
      },
      error: (err) => console.error('No autenticado', err),
    });

    this.categoriasService.obtenerCategorias().subscribe({
      next: (data) => (this.categorias = data),
      error: (err) => console.error('Error cargando categorías', err),
    });

    this.taskForm.get('idCategoria')?.valueChanges.subscribe((value) => {
      if (value && value !== '') {
        this.nuevaCategoria = '';
        this.errorCategoria = '';
      }
    });

    const modoGuardado = localStorage.getItem('modoOscuro');
    this.modoOscuroActivado = modoGuardado === 'true';
    this.aplicarModoOscuro();
  }

  /* =========================================================================
   * CARGA DE TAREAS
   * ========================================================================= */
  cargarTareas(): void {
    this.taskService.getTasks().subscribe({
      next: (res) => {
        this.tareas = res.map((t: any) => ({
          ...t,
          estado: t.estado?.toLowerCase() || 'pendiente',
        }));
        this.actualizarContadores();
      },
      error: (err) => console.error('Error al cargar tareas:', err),
    });
  }

  /* =========================================================================
   * CRUD DE TAREAS
   * ========================================================================= */

  /** Agregar o actualizar una tarea */
  addTask(): void {
    if (this.taskForm.invalid) return;

    const tareaData = {
      ...this.taskForm.value,
      estado: 'pendiente',
      idCategoria: this.taskForm.value.idCategoria || null,
    };

    if (this.editando && this.tareaEditandoId !== null) {
      this.taskService.updateTask(this.tareaEditandoId, tareaData).subscribe({
        next: () => {
          this.toastr.info('Tarea actualizada 📝');
          this.resetFormulario();
          this.cargarTareas();
        },
        error: (err) => console.error('Error al actualizar tarea:', err),
      });
    } else {
      this.taskService.createTask(tareaData).subscribe({
        next: () => {
          this.toastr.success('Tarea creada exitosamente ✅');
          this.resetFormulario();
          this.cargarTareas();
        },
        error: (err) => console.error('Error al guardar tarea:', err),
      });
    }
  }

  /** Editar tarea existente */
  editarTarea(tarea: any): void {
    this.editando = true;
    this.tareaEditandoId = tarea.idTareas;
    this.taskForm.patchValue({
      titulo: tarea.titulo,
      descripcion: tarea.descripcion,
      estado: tarea.estado?.toLowerCase(),
      prioridad: tarea.prioridad?.toLowerCase(),
      fechaLimite: tarea.fechaLimite,
      idCategoria: tarea.idCategoria || '',
    });

    setTimeout(() => this.tituloInput.nativeElement.focus());
  }

  /** Eliminar tarea */
  eliminarTarea(id: number): void {
    if (confirm('¿Seguro que quieres eliminar esta tarea?')) {
      this.taskService.deleteTask(id).subscribe({
        next: () => {
          this.toastr.error('Tarea eliminada 🗑️');
          this.cargarTareas();
        },
        error: (err) => console.error('Error al eliminar tarea:', err),
      });
    }
  }

  /** Cambiar estado de tarea */
  cambiarEstado(id: number, nuevoEstado: string) {
    this.taskService.actualizarEstado(id, nuevoEstado).subscribe(
      () => {
        const tarea = this.tareas.find((t) => t.id === id || t.idTareas === id);
        if (tarea) {
          tarea.estado = nuevoEstado;
          this.actualizarContadores();
        }
        this.toastr.success('Estado actualizado correctamente ✅');
      },
      () => {
        this.toastr.error('No se pudo actualizar el estado ❌');
      }
    );
  }

  /* =========================================================================
   * UTILIDADES
   * ========================================================================= */

  /** Expandir o contraer tarea */
  toggleExpandir(id: number): void {
    this.tareaExpandidaId = this.tareaExpandidaId === id ? null : id;
  }

  /** Reiniciar formulario */
  resetFormulario(): void {
    this.taskForm.reset({
      titulo: '',
      descripcion: '',
      estado: 'pendiente',
      prioridad: '',
      fechaLimite: '',
      idCategoria: '',
    });
    this.editando = false;
    this.tareaEditandoId = null;
    this.nuevaCategoria = '';
    this.errorCategoria = '';

    setTimeout(() => this.tituloInput?.nativeElement.focus());
  }

  /** Obtener clase de prioridad */
  getPrioridadClass(prioridad: string): string {
    switch (prioridad.toLowerCase()) {
      case 'alta':
        return 'tag-alta';
      case 'media':
        return 'tag-media';
      case 'baja':
        return 'tag-baja';
      default:
        return '';
    }
  }

  /** Actualizar contadores de estados */
  actualizarContadores(): void {
    this.pendientesCount = this.tareas.filter((t) => t.estado === 'pendiente').length;
    this.completadasCount = this.tareas.filter((t) => t.estado === 'completada').length;
    this.enProgresoCount = this.tareas.filter((t) => t.estado === 'en_progreso').length;
  }

  /* =========================================================================
   * EXPORTAR DATOS
   * ========================================================================= */
  exportarExcel(): void {
    const worksheet = XLSX.utils.json_to_sheet(this.tareas);
    const workbook = { Sheets: { Tareas: worksheet }, SheetNames: ['Tareas'] };
    const excelBuffer: any = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
    const blob = new Blob([excelBuffer], { type: 'application/octet-stream' });
    FileSaver.saveAs(blob, 'tareas.xlsx');
  }

  exportarPDF(): void {
    const doc = new jsPDF();
    autoTable(doc, {
      head: [['Título', 'Descripción', 'Estado', 'Prioridad', 'Fecha Límite']],
      body: this.tareas.map((t) => [
        t.titulo,
        t.descripcion || '',
        t.estado,
        t.prioridad,
        t.fechaLimite ? new Date(t.fechaLimite).toLocaleDateString() : '',
      ]),
    });
    doc.save('tareas.pdf');
  }

  /* =========================================================================
   * SESIÓN
   * ========================================================================= */
  cerrarSesion(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
    this.toastr.info('Sesión cerrada correctamente 👋');
  }

  /* =========================================================================
   * FILTROS Y BUSQUEDAS
   * ========================================================================= */
  getTareasFiltradas(): any[] {
    let tareasFiltradas = [...this.tareas];

    if (this.filtroActual === 'pendientes') {
      tareasFiltradas = tareasFiltradas.filter((t) => t.estado === 'pendiente');
    } else if (this.filtroActual === 'completadas') {
      tareasFiltradas = tareasFiltradas.filter((t) => t.estado === 'completada');
    } else if (this.filtroActual === 'en_progreso') {
      tareasFiltradas = tareasFiltradas.filter((t) => t.estado === 'en_progreso');
    }

    if (this.filtroBusqueda.trim() !== '') {
      tareasFiltradas = tareasFiltradas.filter((t) =>
        t.titulo.toLowerCase().includes(this.filtroBusqueda.toLowerCase())
      );
    }

    return tareasFiltradas;
  }

  /* =========================================================================
   * CRUD DE CATEGORÍAS
   * ========================================================================= */
  crearCategoria(): void {
    const nombre = this.nuevaCategoria?.trim();
    if (!nombre) {
      this.errorCategoria = 'El nombre no puede estar vacío.';
      return;
    }

    if (this.categorias.some((cat) => cat.nombre.toLowerCase() === nombre.toLowerCase())) {
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
      },
    });
  }

  eliminarCategoriaSeleccionada(): void {
    const id = this.getCategoriaSeleccionadaId();
    if (!id) return;

    const categoria = this.categorias.find((c) => c.idCategoria === id);
    if (!categoria) return;

    if (confirm(`¿Estás seguro de que deseas eliminar la categoría "${categoria.nombre}"?`)) {
      this.categoriasService.eliminarCategoria(id).subscribe({
        next: () => {
          this.categorias = this.categorias.filter((c) => c.idCategoria !== id);
          this.taskForm.get('idCategoria')?.setValue('');
          this.nuevaCategoria = '';
          this.errorCategoria = '';
          this.toastr.success('Categoría eliminada correctamente ✅');
        },
        error: (err) => {
          console.error('Error al eliminar categoría', err);
          this.toastr.error('No se pudo eliminar la categoría ❌');
        },
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
    return idSel !== null && this.categorias.some((c) => c.idCategoria === idSel);
  }

  getNombreCategoriaSeleccionada(): string {
    const id = this.getCategoriaSeleccionadaId();
    if (!id) return '';
    const categoria = this.categorias.find((c) => c.idCategoria === id);
    return categoria ? categoria.nombre : '';
  }

  mostrarInputNuevaCategoria(): boolean {
    return !this.esCategoriaExistenteSeleccionada();
  }

  /* =========================================================================
   * FILTROS DE VISUALIZACIÓN
   * ========================================================================= */
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

  /* =========================================================================
   * MODO OSCURO
   * ========================================================================= */
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
