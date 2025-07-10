<?php

namespace Database\Factories;

use App\Models\Categoria;
use Illuminate\Database\Eloquent\Factories\Factory;

class CategoriaFactory extends Factory
{
    // ✅ Asociar esta factory con el modelo Categoria
    protected $model = Categoria::class;

    public function definition(): array
    {
        return [
            'nombre'      => $this->faker->word(),
            'descripcion' => $this->faker->sentence(), // Opcional si tu campo lo acepta
        ];
    }
}
