<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tarea extends Model
{
    use HasFactory;

    protected $table = 'tareas';
    protected $primaryKey = 'idTareas';
    public $incrementing = true;
    protected $keyType = 'int';

    protected $fillable = [
        'idUsuario',
        'idCategoria',
        'titulo',
        'descripcion',
        'estado',
        'prioridad',
        'fechaLimite',
    ];

    // Relaciones
    public function usuario()
    {
        return $this->belongsTo(User::class, 'idUsuario');
    }

    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'idCategoria', 'idCategoria');
    }

    // Relación con el historial de tareas
    public function historial()
    {
        return $this->hasMany(HistorialTarea::class, 'idTareas', 'idTareas');
    }

    // Accesor para formatear la fechaLimite
    public function getFechaLimiteAttribute($value)
    {
        return \Carbon\Carbon::parse($value)->format('Y-m-d');
    }

    // Cast de campos
    protected $casts = [
        'fechaLimite' => 'date',
    ];
}