<?php

namespace App\Http\Controllers;

use App\Models\Tarea;
use App\Models\HistorialTarea;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class TareaController extends Controller
{
    // Listar todas las tareas del usuario autenticado
    public function index(Request $request)
{
    $user = $request->user();

    $tareas = Tarea::with('categoria')
        ->where('idUsuario', $user->id)
        ->get();

    return response()->json($tareas);
}


    // Crear una nueva tarea
    public function store(Request $request)
    {
        $request->validate([
            'titulo'      => 'required|string|max:100',
            'descripcion' => 'nullable|string',
            'prioridad'   => 'required|string',
            'fechaLimite' => 'nullable|date',
            'idCategoria' => 'nullable|exists:categorias,idCategoria',
        ]);

        $tarea = Tarea::create([
            'titulo'      => $request->titulo,
            'descripcion' => $request->descripcion,
            'estado'      => 'Pendiente', // se lo asigna por defecto
            'prioridad'   => $request->prioridad,
            'fechaLimite' => $request->fechaLimite,
            'idCategoria' => $request->idCategoria,
            'idUsuario'   => $request->user()->id,
        ]);

        HistorialTarea::create([
            'idTareas'       => $tarea->idTareas,
            'idUsuario'      => $request->user()->id,
            'accion'         => 'creación',
            'detalle_cambio' => "Tarea '{$tarea->titulo}' fue creada",
            'fechaCambio'    => now(),
        ]);

        return response()->json($tarea, 201);
    }

    // Mostrar detalle de una tarea específica
    public function show(Request $request, $id)
{
    // Verifica que el ID sea numérico
    if (!is_numeric($id)) {
        return response()->json(['message' => 'ID inválido'], 400);
    }

    // Intentamos obtener la tarea, o capturamos el error si no existe
    try {
        $tarea = Tarea::with('categoria')->findOrFail($id);
    } catch (ModelNotFoundException $e) {
        return response()->json(['message' => 'Tarea no encontrada'], 404);
    }

    // Verificamos que el usuario autenticado sea el dueño
    if ($request->user()->id !== $tarea->idUsuario) {
        return response()->json(['message' => 'No autorizado'], 403);
    }

    return response()->json($tarea);
}

    // Actualizar una tarea
    public function update(Request $request, $id)
{
    $tarea = Tarea::find($id);
    if (!$tarea) {
        return response()->json(['message' => 'Tarea no encontrada'], 404);
    }

    if ($request->user()->id !== $tarea->idUsuario) {
        return response()->json(['message' => 'No autorizado'], 403);
    }

    $request->validate([
        'titulo'      => 'sometimes|required|string|max:100',
        'descripcion' => 'nullable|string',
        'estado'      => 'sometimes|required|string',
        'prioridad'   => 'sometimes|required|string',
        'fechaLimite' => 'nullable|date',
        'idCategoria' => 'nullable|exists:categorias,idCategoria',
    ]);

    $original = $tarea->getOriginal();

    $tarea->update($request->only([
        'titulo',
        'descripcion',
        'estado',
        'prioridad',
        'fechaLimite',
        'idCategoria',
    ]));

    $cambios = [];
    foreach ($tarea->getChanges() as $campo => $nuevoValor) {
        if ($campo === 'updated_at') continue;
        $anterior = $original[$campo] ?? 'N/A';
        $cambios[] = "$campo: '$anterior' -> '$nuevoValor'";
    }

    if (count($cambios) > 0) {
        \Log::info('Registrando cambios en historial para tarea ID: ' . $tarea->idTareas);
        \Log::info('Cambios: ', $cambios);

        HistorialTarea::create([
            'idTareas'       => $tarea->idTareas,
            'idUsuario'      => $request->user()->id,
            'accion'         => 'actualización',
            'detalle_cambio' => implode(', ', $cambios),
            'fechaCambio'    => now(),
        ]);
    }

    return response()->json($tarea);
}


    // Mostrar historial de tareas del usuario autenticado
    public function historial($idTarea)
    {
        if (!is_numeric($idTarea)) {
            return response()->json(['error' => 'ID de tarea inválido'], 400);
        }

        $historial = HistorialTarea::where('idTareas', $idTarea)->get();

        if ($historial->isEmpty()) {
            return response()->json(['message' => 'No se encontró historial para esta tarea.'], 404);
        }

        return response()->json($historial);
    }

    // Eliminar una tarea
    public function destroy(Request $request, $id)
{
    $tarea = Tarea::find($id);
    if (!$tarea) {
        return response()->json(['message' => 'Tarea no encontrada'], 404);
    }

    if ($request->user()->id !== $tarea->idUsuario) {
        return response()->json(['message' => 'No autorizado'], 403);
    }

    \Log::info('Eliminando tarea ID: ' . $tarea->idTareas);
    \Log::info('Detalles de la tarea: ', [
        'idTareas'  => $tarea->idTareas,
        'idUsuario' => $request->user()->id,
        'titulo'    => $tarea->titulo,
    ]);

    // Registrar en historial ANTES de eliminar
    HistorialTarea::create([
        'idTareas'       => $tarea->idTareas,
        'idUsuario'      => $request->user()->id,
        'accion'         => 'eliminación',
        'detalle_cambio' => "Tarea '{$tarea->titulo}' fue eliminada",
        'fechaCambio'    => now(),
    ]);

    $tarea->delete();

    return response()->json(['message' => 'Tarea eliminada']);
}

// metodo para actualizar el estado
public function actualizarEstado(Request $request, $id)
{
    $tarea = Tarea::find($id);
    if(!$tarea){
        return response()->json(['message' => 'Tarea no encontrada'], 404);
    }

    if($request->user()->id !== $tarea->idUsuario){
        return response()->json(['message' => 'No autorizado'], 403);
    }

    $request->validate([
        'estado' => 'required|string',
    ]);

    $original = $tarea->estado;
    $tarea->estado = $request->estado;
    $tarea->save();

    HistorialTarea::create([
        'idTareas'       =>$tarea->idTareas,
        'idUsuario'      =>$request->user()->id,
        'accion'         =>'actualización',
        'detalle_cambio' =>"Estado: '$original' -> '{$request->estado}'",
        'fechaCambio'    =>now(),
    ]);

    return response()->json($tarea);
}

}
