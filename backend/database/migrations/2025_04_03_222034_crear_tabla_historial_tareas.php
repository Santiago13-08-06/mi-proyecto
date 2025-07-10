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
        Schema::create('historial_tareas', function (Blueprint $table) {
            $table->id('idHistorial'); 
        $table->unsignedBigInteger('idTareas'); 
        $table->unsignedBigInteger('idUsuario'); 
        $table->string('accion');
        $table->text('detalle_cambio');
        $table->timestamp('fechaCambio')->useCurrent();

        // Definimos FK
        $table->foreign('idTareas')->references('idTareas')->on('tareas')->onDelete('cascade');
        $table->foreign('idUsuario')->references('id')->on('usuarios')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('historial_tareas');
    }
};
