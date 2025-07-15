/**
 * Define la estructura base de una tarea en el sistema.
 */
export interface Tarea {
  /**
   * Identificador único de la tarea.
   */
  idTareas: number;

  /**
   * Título de la tarea.
   */
  titulo: string;

  /**
   * Descripción opcional de la tarea.
   */
  descripcion?: string;

  /**
   * Estado de la tarea.
   * Opciones: pendiente, en_progreso o completada.
   */
  estado: 'pendiente' | 'en_progreso' | 'completada';

  /**
   * Prioridad de la tarea.
   * Opciones: baja, media o alta.
   */
  prioridad: 'baja' | 'media' | 'alta';

  /**
   * Fecha límite opcional para completar la tarea.
   * Formato utilizado: YYYY-MM-DD.
   */
  fechaLimite?: string;
}
