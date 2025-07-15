import { Pipe, PipeTransform } from '@angular/core';

/**
 * Pipe personalizado para filtrar tareas por término de búsqueda.
 * Se utiliza en la vista para mostrar solo las tareas cuyo título
 * contenga el texto buscado (insensible a mayúsculas).
 */
@Pipe({
  name: 'filtroTarea',
  standalone: true, // Habilita el pipe como standalone.
})
export class FiltroTareaPipe implements PipeTransform {
  /**
   * Transforma la lista de tareas filtrándolas por el término indicado.
   * @param tareas Lista de tareas a filtrar.
   * @param termino Texto de búsqueda.
   * @returns Lista de tareas filtradas.
   */
  transform(tareas: any[], termino: string): any[] {
    if (!termino) return tareas;

    const filtro = termino.toLowerCase();

    return tareas.filter((t) => t.titulo.toLowerCase().includes(filtro));
  }
}
