export interface Tarea {
  idTareas: number;
  titulo: string;
  descripcion?: string;
  estado: 'pendiente' | 'en_progreso' | 'completada';
  prioridad: 'baja' | 'media' | 'alta';
  fechaLimite?: string;
}
