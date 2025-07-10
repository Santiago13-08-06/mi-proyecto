<?php

namespace Database\Factories;

use App\Models\Tarea;
use App\Models\User;
use App\Models\Categoria;
use Illuminate\Database\Eloquent\Factories\Factory;

class TareaFactory extends Factory
{
    protected $model = Tarea::class;

    public function definition(): array
    {
        return [
            'idUsuario'   => User::factory(),
            'idCategoria' => $this->faker->boolean(80) ? Categoria::factory() : null,
            'titulo'      => $this->faker->sentence(4),
            'descripcion' => $this->faker->paragraph,
            'estado'      => $this->faker->randomElement(['pendiente', 'en progreso', 'completada']),
            'prioridad'   => $this->faker->randomElement(['baja', 'media', 'alta']),
            'fechaLimite' => $this->faker->optional()->dateTimeBetween('now', '+1 month'),
        ];
    }
}
