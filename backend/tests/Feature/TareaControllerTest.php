<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Tarea;
use App\Models\Categoria;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TareaControllerTest extends TestCase
{
    use RefreshDatabase;

    protected $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create();
    }

    /** @test */
    public function puede_listar_tareas_del_usuario_autenticado()
    {
        $this->actingAs($this->user);

        Tarea::factory()->create([
            'idUsuario' => $this->user->id,
        ]);

        $response = $this->getJson('/api/tareas');

        $response->assertStatus(200)
                 ->assertJsonCount(1);
    }

    /** @test */
    public function puede_crear_una_tarea()
    {
        $this->actingAs($this->user);

        $categoria = Categoria::factory()->create();

        $data = [
            'titulo'      => 'Tarea de prueba',
            'descripcion' => 'Descripción',
            'estado'      => 'pendiente',
            'prioridad'   => 'alta',
            'idCategoria' => $categoria->idCategoria,
        ];

        $response = $this->postJson('/api/tareas', $data);

        $response->assertStatus(201)
                 ->assertJsonFragment([
                     'titulo' => 'Tarea de prueba',
                     'idCategoria' => $categoria->idCategoria
                 ]);

        $this->assertDatabaseHas('tareas', [
            'titulo' => 'Tarea de prueba',
            'idUsuario' => $this->user->id,
            'idCategoria' => $categoria->idCategoria
        ]);
    }

    /** @test */
    public function puede_crear_una_tarea_sin_categoria()
    {
        $this->actingAs($this->user);

        $data = [
            'titulo'      => 'Tarea sin categoría',
            'descripcion' => 'Sin categoría',
            'estado'      => 'pendiente',
            'prioridad'   => 'media',
            'idCategoria' => null,
        ];

        $response = $this->postJson('/api/tareas', $data);

        $response->assertStatus(201)
                 ->assertJsonFragment(['titulo' => 'Tarea sin categoría']);

        $this->assertDatabaseHas('tareas', [
            'titulo' => 'Tarea sin categoría',
            'idUsuario' => $this->user->id,
            'idCategoria' => null
        ]);
    }

    /** @test */
    public function puede_ver_una_tarea_individual()
    {
        $this->actingAs($this->user);

        $tarea = Tarea::factory()->create([
            'idUsuario' => $this->user->id,
        ]);

        $response = $this->getJson("/api/tareas/{$tarea->idTareas}");

        $response->assertStatus(200)
                 ->assertJsonFragment(['idTareas' => $tarea->idTareas]);
    }

    /** @test */
    public function no_puede_ver_tarea_de_otra_persona()
    {
        $otroUsuario = User::factory()->create();

        $tarea = Tarea::factory()->create([
            'idUsuario' => $otroUsuario->id,
        ]);

        $this->actingAs($this->user);

        $response = $this->getJson("/api/tareas/{$tarea->idTareas}");

        $response->assertStatus(403);
    }

    /** @test */
    public function puede_actualizar_una_tarea()
    {
        $this->actingAs($this->user);

        $tarea = Tarea::factory()->create([
            'idUsuario' => $this->user->id,
            'titulo'    => 'Título viejo',
        ]);

        $data = ['titulo' => 'Título nuevo'];

        $response = $this->putJson("/api/tareas/{$tarea->idTareas}", $data);

        $response->assertStatus(200)
                 ->assertJsonFragment(['titulo' => 'Título nuevo']);

        $this->assertDatabaseHas('tareas', [
            'idTareas' => $tarea->idTareas,
            'titulo' => 'Título nuevo'
        ]);
    }

    /** @test */
    public function no_puede_actualizar_tarea_de_otro_usuario()
    {
        $otroUsuario = User::factory()->create();

        $tarea = Tarea::factory()->create([
            'idUsuario' => $otroUsuario->id,
            'titulo'    => 'No debe cambiar',
        ]);

        $this->actingAs($this->user);

        $response = $this->putJson("/api/tareas/{$tarea->idTareas}", [
            'titulo' => 'Intento de cambio',
        ]);

        $response->assertStatus(403);

        $this->assertDatabaseHas('tareas', [
            'idTareas' => $tarea->idTareas,
            'titulo' => 'No debe cambiar',
        ]);
    }

    /** @test */
    public function puede_eliminar_una_tarea()
    {
        $this->actingAs($this->user);

        $tarea = Tarea::factory()->create([
            'idUsuario' => $this->user->id,
        ]);

        $response = $this->deleteJson("/api/tareas/{$tarea->idTareas}");

        $response->assertStatus(200)
                 ->assertJsonFragment(['message' => 'Tarea eliminada']);

        $this->assertDatabaseMissing('tareas', [
            'idTareas' => $tarea->idTareas
        ]);
    }

    /** @test */
    public function no_puede_eliminar_tarea_de_otro_usuario()
    {
        $otroUsuario = User::factory()->create();

        $tarea = Tarea::factory()->create([
            'idUsuario' => $otroUsuario->id,
        ]);

        $this->actingAs($this->user);

        $response = $this->deleteJson("/api/tareas/{$tarea->idTareas}");

        $response->assertStatus(403);

        $this->assertDatabaseHas('tareas', [
            'idTareas' => $tarea->idTareas,
        ]);
    }
}
