<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tareas', function (Blueprint $table) {
            $table->id('idTareas');
            $table->unsignedBigInteger('idUsuario');
            $table->unsignedBigInteger('idCategoria')->nullable();
            $table->string('titulo', length: 100);
            $table->text('descripcion');
            $table->string('estado')->default('Pendiente');
            $table->string('prioridad');
            $table->date('fechaLimite')->nullable();
            $table->timestamps();
        
            $table->foreign('idUsuario')->references('id')->on('usuarios')->onDelete('cascade');
            $table->foreign('idCategoria')->references('idCategoria')->on('categorias')->onDelete('set null');

        });
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tareas');
    }
};
