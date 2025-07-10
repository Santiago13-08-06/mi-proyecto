import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class CategoriasService {
  private apiUrl = 'http://localhost:8000/api/categorias';

  constructor(private http: HttpClient) {}

  obtenerCategorias() {
    return this.http.get<any[]>(this.apiUrl);
  }

  crearCategoria(categoria: { nombre: string }): Observable<any> {
    return this.http.post(`${this.apiUrl}`, categoria);
  }

  eliminarCategoria(id: number): Observable<any> {
  return this.http.delete(`${this.apiUrl}/${id}`);
}


}
