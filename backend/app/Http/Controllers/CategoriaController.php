<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;

class CategoriaController extends Controller
{
    // OBTENER CATEGORIAS DEL USUARIO AUTENTICADO
    public function index(Request $request)
    {
        $categorias = Categoria::where('idUsuario', $request->user()->id)->get();
        return response()->json($categorias);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:100',
        ]);

        $categoria = Categoria::create([
            'nombre' => $request->nombre,
            'idUsuario' => $request->user()->id
        ]);

        return response()->json($categoria, 201);
    }

public function destroy($id, Request $request)
{
    $categoria = Categoria::where('idCategoria', $id)
                          ->where('idUsuario', $request->user()->id)
                          ->firstOrFail();

    $categoria->delete();

    return response()->json(['message' => 'Categoría eliminada'], 200);
}


}
