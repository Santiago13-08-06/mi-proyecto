<?php

namespace App\Exceptions;

use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * Un arreglo de los tipos de excepciones que no se deben reportar.
     *
     * @var array<int, class-string<Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * Un arreglo de las entradas que nunca se deben mostrar en las excepciones de validación.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Registrar las funciones de manejo de excepciones.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });
    }

    /**
     * Personaliza la respuesta cuando un usuario no está autenticado.
     */
    protected function unauthenticated($request, AuthenticationException $exception)
    {
        if ($request->expectsJson()) {
            return response()->json([
                'message' => 'No autenticado.',
            ], 401);
        }

        // Si no es una solicitud JSON, redirige (esto es útil si también tienes rutas web)
        return redirect()->guest(route('login'));
    }
}
