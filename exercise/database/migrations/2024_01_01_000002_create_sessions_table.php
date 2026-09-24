<?php

use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     * Support tables (sessions, cache, jobs) are already defined in create_database_support_tables.
     */
    public function up(): void
    {
        // Handled by create_database_support_tables
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Handled by create_database_support_tables
    }
};
