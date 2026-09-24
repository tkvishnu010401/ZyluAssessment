<?php

use App\Http\Controllers\Api\EmployeeController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes for Employee Directory
|--------------------------------------------------------------------------
|
| Exposes endpoints for Flutter client consumption:
| - GET    /api/employees           (list employees, supports ?flagged_green=1, ?is_active=1, ?department=..., ?search=...)
| - GET    /api/employees/summary   (metrics: total, active, inactive, flagged_green)
| - GET    /api/employees/{id}      (retrieve single employee details)
| - POST   /api/employees           (create new employee record)
| - PUT    /api/employees/{id}      (update employee record)
| - DELETE /api/employees/{id}      (delete employee record)
|
*/

Route::prefix('employees')->group(function () {
    Route::get('/summary', [EmployeeController::class, 'summary']);
    Route::get('/', [EmployeeController::class, 'index']);
    Route::get('/{id}', [EmployeeController::class, 'show']);
    Route::post('/', [EmployeeController::class, 'store']);
    Route::put('/{id}', [EmployeeController::class, 'update']);
    Route::delete('/{id}', [EmployeeController::class, 'destroy']);
});
