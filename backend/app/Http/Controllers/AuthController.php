<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // Registrar un nuevo usuario
    public function register(Request $request)
    {
        $request->validate([
            'nombreCompleto' => 'required|string|max:255',
            'email' => 'required|email|unique:usuarios,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $usuario = User::create([
            'nombreCompleto' => $request->nombreCompleto,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json(['message' => 'Usuario registrado correctamente', 'usuario' => $usuario], 201);
    }

    // Iniciar sesión y devolver token
public function login(Request $request)
{
    $request->validate([
        'email'    => 'required|string|email',
        'password' => 'required|string',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        return response()->json([
            'message' => 'Las credenciales son incorrectas.'
        ], 401); // 401 para error de autenticación
    }

    $token = $user->createToken('token')->plainTextToken;

    return response()->json([
        'user'  => $user,
        'token' => $token,
    ]);
}


    // Obtener datos del usuario autenticado
    public function me(Request $request)
    {
        return response()->json([
            'user' => $request->user()
        ]);
    }

    // Cerrar sesión (revocar token)
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Sesión cerrada']);
    }
}
