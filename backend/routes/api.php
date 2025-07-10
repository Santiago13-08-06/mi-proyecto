<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\TareaController;
use Illuminate\Http\Middleware\HandleCors;
use App\Http\Controllers\CategoriaController;





// Aplica middleware CORS a todas las rutas del archivo
Route::middleware([HandleCors::class])->group(function () {

    // Ruta de prueba para verificar que funciona
    Route::get('/ping', function () {
        return response()->json(['message' => 'pong']);
    });
   // Rutas de autenticación
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/tareas', [TareaController::class, 'index']);
        Route::post('/tareas', [TareaController::class, 'store']);
        Route::get('/categorias', [CategoriaController::class, 'index']);
        Route::post('/categorias', [CategoriaController::class, 'store']);
        Route::delete('/categorias/{id}', [CategoriaController::class, 'destroy']);
        Route::get('/tareas/{id}', [TareaController::class, 'show'])->where('id', '[0-9]+');
        Route::put('/tareas/{id}', [TareaController::class, 'update'])->where('id', '[0-9]+');
        Route::put('/tareas/{id}/estado', [TareaController::class, 'actualizarEstado']);
        Route::get('/tareas/historial/{idTarea}', [TareaController::class, 'historial']);
        Route::delete('/tareas/{id}', [TareaController::class, 'destroy'])->where('id', '[0-9]+');

    });

});
