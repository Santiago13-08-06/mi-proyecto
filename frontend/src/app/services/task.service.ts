import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Tarea } from '../models/tarea.model';

@Injectable({
  providedIn: 'root',
})
export class TaskService {
  private apiUrl = 'http://localhost:8000/api/tareas';

  constructor(private http: HttpClient) {}

  /**
   * Obtiene la lista de tareas del usuario autenticado.
   */
  getTasks(): Observable<Tarea[]> {
    return this.http.get<Tarea[]>(this.apiUrl, { withCredentials: true });
  }

  /**
   * Crea una nueva tarea.
   * @param taskData Objeto con los datos de la tarea.
   */
  createTask(taskData: Tarea): Observable<Tarea> {
    return this.http.post<Tarea>(this.apiUrl, taskData, { withCredentials: true });
  }

  /**
   * Actualiza una tarea existente por su ID.
   * @param id ID de la tarea.
   * @param taskData Datos actualizados.
   */
  updateTask(id: number, taskData: Tarea): Observable<Tarea> {
    return this.http.put<Tarea>(`${this.apiUrl}/${id}`, taskData, { withCredentials: true });
  }

  /**
   * Actualiza solo el estado de una tarea.
   * @param id ID de la tarea.
   * @param estado Nuevo estado ('pendiente', 'en_progreso', 'completada').
   */
  actualizarEstado(id: number, estado: string): Observable<Tarea> {
    return this.http.put<Tarea>(
      `${this.apiUrl}/${id}/estado`,
      { estado },
      { withCredentials: true }
    );
  }

  /**
   * Elimina una tarea por su ID.
   * @param id ID de la tarea a eliminar.
   */
  deleteTask(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`, { withCredentials: true });
  }
}
