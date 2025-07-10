import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TaskService {
  private apiUrl = 'http://localhost:8000/api/tareas';

  constructor(private http: HttpClient) {}

  getTasks(): Observable<any> {
    return this.http.get(this.apiUrl, { withCredentials: true });
  }

  createTask(taskData: any): Observable<any> {
    return this.http.post(this.apiUrl, taskData, { withCredentials: true });
  }

  updateTask(id: number, taskData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}`, taskData, { withCredentials: true });
  }

  actualizarEstado(id: number, estado: String): Observable<any>{
    return this.http.put(`${this.apiUrl}/${id}/estado`, { estado }, { withCredentials: true });
  }

  deleteTask(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`, { withCredentials: true });
  }
}
