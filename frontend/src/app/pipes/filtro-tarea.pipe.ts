import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filtroTarea',
  standalone: true
})
export class FiltroTareaPipe implements PipeTransform {
  transform(tareas: any[], termino: string): any[] {
    if (!termino) return tareas;
    const filtro = termino.toLowerCase();
    return tareas.filter(t => t.titulo.toLowerCase().includes(filtro));
  }
}
