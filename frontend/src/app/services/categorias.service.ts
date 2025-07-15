import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CategoriasService {
  private apiUrl = 'http://localhost:8000/api/categorias';

  constructor(private http: HttpClient) {}

  /**
   * Obtiene la lista de categorías.
   */
  obtenerCategorias(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  /**
   * Crea una nueva categoría.
   * @param categoria Objeto con datos de la nueva categoría.
   */
  crearCategoria(categoria: { nombre: string }): Observable<any> {
    return this.http.post(this.apiUrl, categoria);
  }

  /**
   * Elimina una categoría por su ID.
   * @param id ID de la categoría a eliminar.
   */
  eliminarCategoria(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }
}
