<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Categoria extends Model
{

    use HasFactory;

    protected $table = 'categorias';
    protected $primaryKey = 'idCategoria';
    public $timestamps = false;

    protected $fillable = [
        'nombre', 'descripcion', 'idUsuario'
    ];

    public function tareas(): HasMany
    {
        return $this->hasMany(Tarea::class, 'idCategoria');
    }
}
