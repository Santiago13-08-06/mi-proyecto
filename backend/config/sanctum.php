<?php

use Laravel\Sanctum\Sanctum;

return [

    /*
    |--------------------------------------------------------------------------
    | Stateful Domains
    |--------------------------------------------------------------------------
    |
    | Esto se usa cuando trabajas con autenticación basada en cookies, como en
    | una SPA con frontend en React o Vue. Como estás usando tokens Bearer,
    | lo dejamos vacío.
    |
    */

    'stateful' => explode(',', env('SANCTUM_STATEFUL_DOMAINS', 'localhost:4200')),

    /*
    |--------------------------------------------------------------------------
    | Sanctum Guards
    |--------------------------------------------------------------------------
    |
    | Aquí definimos los guards que se usarán para autenticar peticiones. 
    | No cambies esto si estás usando tokens Bearer con Laravel Sanctum.
    |
    */

    'guard' => ['web'],

    /*
    |--------------------------------------------------------------------------
    | Expiration Minutes
    |--------------------------------------------------------------------------
    |
    | Puedes definir cuántos minutos dura el token. Si se deja en null,
    | los tokens no expirarán automáticamente.
    |
    */

    'expiration' => null,

    /*
    |--------------------------------------------------------------------------
    | Token Prefix
    |--------------------------------------------------------------------------
    |
    | Puedes agregar un prefijo a los tokens generados, por ejemplo "skt_".
    | Es útil para seguridad en GitHub u otros escaneos.
    |
    */

    'token_prefix' => env('SANCTUM_TOKEN_PREFIX', ''),

    /*
    |--------------------------------------------------------------------------
    | Sanctum Middleware
    |--------------------------------------------------------------------------
    |
    | Middleware necesarios si usas Sanctum en modo SPA con cookies.
    | Aunque no se usen ahora, los dejamos por si cambias luego.
    |
    */

    'middleware' => [
        'authenticate_session' => Laravel\Sanctum\Http\Middleware\AuthenticateSession::class,
        'encrypt_cookies' => Illuminate\Cookie\Middleware\EncryptCookies::class,
        'validate_csrf_token' => Illuminate\Foundation\Http\Middleware\ValidateCsrfToken::class,
    ],

];
