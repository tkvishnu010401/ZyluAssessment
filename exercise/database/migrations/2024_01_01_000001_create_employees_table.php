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
        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->string('phone')->nullable();
            $table->string('department');
            $table->string('designation');
            $table->string('avatar_url')->nullable();
            $table->date('joining_date');
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            // Indexes for fast querying & filtering
            $table->index('is_active');
            $table->index('joining_date');
            $table->index('department');
            $table->index(['is_active', 'joining_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};
