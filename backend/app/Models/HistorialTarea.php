<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HistorialTarea extends Model
{
    protected $primaryKey = 'idHistorial';
    public $incrementing = true;
    protected $keyType = 'int';
    public $timestamps = false;  // Esto está bien si no quieres los timestamps automáticos

    protected $fillable = [
        'idTareas',
        'idUsuario',
        'accion',
        'detalle_cambio',
        'fechaCambio',
    ];

    // Relación con la tarea
    public function tarea()
    {
        return $this->belongsTo(Tarea::class, 'idTareas', 'idTareas');
    }

    // Relación con el usuario
    public function usuario()
    {
        return $this->belongsTo(User::class, 'idUsuario');
    }
}
