<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'name' => config('app.name'),
        'version' => '1.0.0',
        'status' => 'healthy',
        'endpoints' => [
            'employees' => url('/api/employees'),
            'summary' => url('/api/employees/summary'),
        ],
    ]);
});
