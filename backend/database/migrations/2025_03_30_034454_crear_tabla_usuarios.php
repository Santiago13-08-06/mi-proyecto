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
        Schema::create('usuarios', function (Blueprint $table) {
            $table->id();
            $table->string('nombreCompleto', length: 100);
            $table->string('email', length: 100)->unique();
            $table->string('password', length: 150);
            // Campos necesarios por Laravel
            $table->timestamp('email_verified_at')->nullable();
            $table->rememberToken(); // <- importante para autenticación
            $table->timestamps(); // crea created_at y updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('usuarios');
    }
};
